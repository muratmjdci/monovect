import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';

part 'isolate_manager.dart';

class NetworkService {
  late final Dio _dio;
  late final _IsolateManager _isolateManager;
  static NetworkService? _instance;
  bool _isInitialized = false;

  NetworkService._internal({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers: headers ?? {},
        responseType: ResponseType.plain,
      ),
    );

    _isolateManager = _IsolateManager.instance;
    _setupInterceptors();
  }

  factory NetworkService({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
  }) {
    _instance ??= NetworkService._internal(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
    );
    return _instance!;
  }

  Future<void> initialize() async {
    if (_isInitialized) return;
    await _isolateManager.initialize();
    _isInitialized = true;
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Handle errors and return appropriate message
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode ?? "Unknown"}';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      case DioExceptionType.connectionError:
        return 'Connection error. Please check your internet connection.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate. Please check your connection.';
      case DioExceptionType.unknown:
        return 'Network error: ${error.message ?? "Unknown error"}';
    }
  }

  Future<NetworkResult<T>> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseSingle<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// GET request for list with isolate parsing
  Future<NetworkResult<List<T>>> getList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseList<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// POST request with isolate parsing
  Future<NetworkResult<T>> post<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseSingle<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// POST request for list with isolate parsing
  Future<NetworkResult<List<T>>> postList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseList<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// PUT request with isolate parsing
  Future<NetworkResult<T>> put<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseSingle<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// PUT request for list with isolate parsing
  Future<NetworkResult<List<T>>> putList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseList<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// DELETE request with isolate parsing
  Future<NetworkResult<T>> delete<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseSingle<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// DELETE request for list with isolate parsing
  Future<NetworkResult<List<T>>> deleteList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseList<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Unexpected error: $e');
    }
  }

  /// Download file with progress tracking
  Future<NetworkResult<String>> downloadFile({
    required String url,
    required String savePath,
    void Function(int received, int total)? onProgress,
    Options? options,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
        options: options,
      );

      return NetworkResult.success(savePath);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Download error: $e');
    }
  }

  /// Upload file with progress tracking
  Future<NetworkResult<T>> uploadFile<T>({
    required String endpoint,
    required String filePath,
    required T Function(Map<String, dynamic>) fromJson,
    String fileKey = 'file',
    Map<String, dynamic>? data,
    void Function(int sent, int total)? onProgress,
    Options? options,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        fileKey: await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onProgress,
        options: options,
      );

      if (response.data == null || response.data.toString().isEmpty) {
        return NetworkResult.failure(
          'Empty response from server',
          statusCode: response.statusCode,
        );
      }

      final parsed = await _isolateManager.parseSingle<T>(
        response.data.toString(),
        fromJson,
      );

      return NetworkResult.success(parsed, statusCode: response.statusCode);
    } on DioException catch (e) {
      return NetworkResult.failure(
        _handleError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return NetworkResult.failure('Upload error: $e');
    }
  }

  /// Cancel all pending requests
  void cancelAllRequests() {
    _dio.close(force: true);
  }

  /// Dispose the service and cleanup resources
  void dispose() {
    cancelAllRequests();
    _isolateManager.dispose();
    _isInitialized = false;
    _instance = null;
  }
}

class NetworkResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;
  final int? statusCode;

  NetworkResult._({
    this.data,
    this.error,
    required this.isSuccess,
    this.statusCode,
  });

  factory NetworkResult.success(T data, {int? statusCode}) {
    return NetworkResult._(data: data, isSuccess: true, statusCode: statusCode);
  }

  factory NetworkResult.failure(String error, {int? statusCode}) {
    return NetworkResult._(
      error: error,
      isSuccess: false,
      statusCode: statusCode,
    );
  }
}
