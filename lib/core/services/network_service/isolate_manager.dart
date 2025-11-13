part of 'network_service.dart';

class _IsolateManager {
  static _IsolateManager? _instance;
  Isolate? _isolate;
  SendPort? _sendPort;
  final _receivePort = ReceivePort();
  final Map<int, Completer<dynamic>> _pendingRequests = {};
  int _nextRequestId = 0;
  bool _isInitialized = false;

  _IsolateManager._();

  static _IsolateManager get instance {
    _instance ??= _IsolateManager._();
    return _instance!;
  }

  /// Initialize the worker isolate
  Future<void> initialize() async {
    if (_isInitialized) return;

    final initPort = ReceivePort();

    _isolate = await Isolate.spawn(_isolateWorker, initPort.sendPort);

    _sendPort = await initPort.first as SendPort;
    initPort.close();

    _receivePort.listen(_handleResponse);
    _isInitialized = true;
  }

  /// Worker isolate entry point
  static void _isolateWorker(SendPort mainSendPort) {
    final receivePort = ReceivePort();
    mainSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is! Map<String, dynamic>) return;

      final request = _parseRequestFromMap(message);
      if (request == null) return;

      _ParseResponse response;

      try {
        if (request.type == _ParseType.single) {
          final decoded = json.decode(request.rawData);
          response = _ParseResponse(id: request.id, data: decoded);
        } else {
          final decoded = json.decode(request.rawData) as List<dynamic>;
          response = _ParseResponse(id: request.id, data: decoded);
        }
      } catch (e) {
        response = _ParseResponse(id: request.id, error: 'Parse error: $e');
      }

      mainSendPort.send(_responseToMap(response));
    });
  }

  /// Convert request to map for sending to isolate
  static Map<String, dynamic> _requestToMap(_ParseRequest request) {
    return {
      'id': request.id,
      'rawData': request.rawData,
      'type': request.type.index,
    };
  }

  /// Parse request from map received in isolate
  static _ParseRequest? _parseRequestFromMap(Map<String, dynamic> map) {
    try {
      return _ParseRequest(
        id: map['id'] as int,
        rawData: map['rawData'] as String,
        type: _ParseType.values[map['type'] as int],
      );
    } catch (e) {
      return null;
    }
  }

  /// Convert response to map for sending back
  static Map<String, dynamic> _responseToMap(_ParseResponse response) {
    return {'id': response.id, 'data': response.data, 'error': response.error};
  }

  /// Parse response from map
  static _ParseResponse _parseResponseFromMap(Map<String, dynamic> map) {
    return _ParseResponse(
      id: map['id'] as int,
      data: map['data'],
      error: map['error'] as String?,
    );
  }

  /// Handle response from isolate
  void _handleResponse(dynamic message) {
    if (message is! Map<String, dynamic>) return;

    final response = _parseResponseFromMap(message);
    final completer = _pendingRequests.remove(response.id);

    if (completer == null) return;

    if (response.error != null) {
      completer.completeError(Exception(response.error));
    } else {
      completer.complete(response.data);
    }
  }

  /// Parse single object
  Future<T> parseSingle<T>(
    String rawData,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    if (!_isInitialized) await initialize();

    final requestId = _nextRequestId++;
    final completer = Completer<dynamic>();
    _pendingRequests[requestId] = completer;

    final request = _ParseRequest(
      id: requestId,
      rawData: rawData,
      type: _ParseType.single,
    );

    _sendPort!.send(_requestToMap(request));

    final decodedData = await completer.future;
    return fromJson(decodedData as Map<String, dynamic>);
  }

  /// Parse list of objects
  Future<List<T>> parseList<T>(
    String rawData,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    if (!_isInitialized) {
      await initialize();
    }

    final requestId = _nextRequestId++;
    final completer = Completer<dynamic>();
    _pendingRequests[requestId] = completer;

    final request = _ParseRequest(
      id: requestId,
      rawData: rawData,
      type: _ParseType.list,
    );

    _sendPort!.send(_requestToMap(request));

    final decodedData = await completer.future;
    final list = decodedData as List<dynamic>;
    return list.map((item) => fromJson(item as Map<String, dynamic>)).toList();
  }

  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _receivePort.close();
    _pendingRequests.clear();
    _isInitialized = false;
    _instance = null;
  }
}

/// Message types for isolate communication
enum _ParseType { single, list }

/// Message sent to the worker isolate
class _ParseRequest {
  final int id;
  final String rawData;
  final _ParseType type;

  _ParseRequest({required this.id, required this.rawData, required this.type});
}

/// Response from the worker isolate
class _ParseResponse {
  final int id;
  final dynamic data;
  final String? error;

  _ParseResponse({required this.id, this.data, this.error});
}
