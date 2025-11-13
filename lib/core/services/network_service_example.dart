import 'network_service/network_service.dart';

/// Example usage of the NetworkService with persistent isolate parsing.
///
/// IMPORTANT: Initialize the NetworkService when your app starts:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // Initialize network service (spawns the persistent worker isolate)
///   await NetworkService().initialize();
///
///   runApp(MyApp());
/// }
/// ```
///
/// The service uses a single persistent isolate for all JSON parsing operations,
/// which prevents spawning new isolates for each request and provides better
/// performance. All network responses are parsed in this separate thread,
/// preventing UI freezing even with large JSON payloads.

/// Example model class
class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

/// Example usage of NetworkService
class NetworkServiceExample {
  final NetworkService _networkService = NetworkService(
    baseUrl: 'https://api.example.com',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  /// Initialize the service (call this when app starts)
  Future<void> init() async {
    await _networkService.initialize();
  }

  /// Example GET request
  Future<void> exampleGetRequest() async {
    final result = await _networkService.get<User>(
      endpoint: '/users/1',
      fromJson: User.fromJson,
    );

    if (result.isSuccess) {
      print('User: ${result.data?.name}');
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example GET list request
  Future<void> exampleGetListRequest() async {
    final result = await _networkService.getList<User>(
      endpoint: '/users',
      fromJson: User.fromJson,
      queryParameters: {
        'page': 1,
        'limit': 10,
      },
    );

    if (result.isSuccess) {
      print('Users count: ${result.data?.length}');
      result.data?.forEach((user) {
        print('User: ${user.name}');
      });
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example POST request
  Future<void> examplePostRequest() async {
    final newUser = User(
      id: 0,
      name: 'John Doe',
      email: 'john@example.com',
    );

    final result = await _networkService.post<User>(
      endpoint: '/users',
      fromJson: User.fromJson,
      data: newUser.toJson(),
    );

    if (result.isSuccess) {
      print('Created user: ${result.data?.name}');
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example PUT request
  Future<void> examplePutRequest() async {
    final updatedUser = User(
      id: 1,
      name: 'Jane Doe',
      email: 'jane@example.com',
    );

    final result = await _networkService.put<User>(
      endpoint: '/users/1',
      fromJson: User.fromJson,
      data: updatedUser.toJson(),
    );

    if (result.isSuccess) {
      print('Updated user: ${result.data?.name}');
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example DELETE request
  Future<void> exampleDeleteRequest() async {
    final result = await _networkService.delete<Map<String, dynamic>>(
      endpoint: '/users/1',
      fromJson: (json) => json,
    );

    if (result.isSuccess) {
      print('User deleted successfully');
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example file upload
  Future<void> exampleFileUpload() async {
    final result = await _networkService.uploadFile<Map<String, dynamic>>(
      endpoint: '/upload',
      filePath: '/path/to/file.jpg',
      fromJson: (json) => json,
      fileKey: 'image',
      data: {
        'userId': 1,
        'description': 'Profile picture',
      },
      onProgress: (sent, total) {
        print('Upload progress: ${(sent / total * 100).toStringAsFixed(2)}%');
      },
    );

    if (result.isSuccess) {
      print('File uploaded successfully');
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example file download
  Future<void> exampleFileDownload() async {
    final result = await _networkService.downloadFile(
      url: 'https://example.com/file.pdf',
      savePath: '/path/to/save/file.pdf',
      onProgress: (received, total) {
        print(
            'Download progress: ${(received / total * 100).toStringAsFixed(2)}%');
      },
    );

    if (result.isSuccess) {
      print('File downloaded to: ${result.data}');
    } else {
      print('Error: ${result.error}');
    }
  }

  /// Example with authentication
  Future<void> exampleWithAuth() async {
    // Set auth token
    _networkService.setAuthToken('your_token_here');

    final result = await _networkService.get<User>(
      endpoint: '/users/me',
      fromJson: User.fromJson,
    );

    if (result.isSuccess) {
      print('Current user: ${result.data?.name}');
    } else {
      print('Error: ${result.error}');
    }

    // Clear auth token when done
    _networkService.clearAuthToken();
  }

  /// Example error handling
  Future<void> exampleErrorHandling() async {
    final result = await _networkService.get<User>(
      endpoint: '/invalid-endpoint',
      fromJson: User.fromJson,
    );

    if (result.isSuccess) {
      print('User: ${result.data?.name}');
    } else {
      // Handle different error scenarios
      print('Error occurred: ${result.error}');
      print('Status code: ${result.statusCode}');

      // You can show different UI based on status code
      switch (result.statusCode) {
        case 404:
          print('Resource not found');
          break;
        case 401:
          print('Unauthorized - redirect to login');
          break;
        case 500:
          print('Server error - try again later');
          break;
        default:
          print('Unknown error');
      }
    }
  }
}
