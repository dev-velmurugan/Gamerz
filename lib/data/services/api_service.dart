import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'https://api.gamerzbank.com/v1'; // Replace with actual API
  static const String _tokenKey = 'auth_token';

  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(_tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) {
          _handleError(error);
          handler.next(error);
        },
      ),
    );

    // Logging interceptor (only in debug mode)
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ),
    );
  }

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        throw Exception('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          // Handle unauthorized - clear token and redirect to login
          _clearToken();
        }
        throw Exception('Server error: ${error.response?.data['message'] ?? 'Unknown error'}');
      case DioExceptionType.connectionError:
        throw Exception('No internet connection. Please check your network.');
      default:
        throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // AUTH ENDPOINTS
  Future<Map<String, dynamic>> sendOtp(String mobile) async {
    // Mock implementation - replace with actual API
    await Future.delayed(const Duration(seconds: 1));
    return {'success': true, 'message': 'OTP sent successfully'};
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    // Mock implementation - replace with actual API
    await Future.delayed(const Duration(seconds: 1));
    return {
      'success': true,
      'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': 'user_001',
        'mobile': mobile,
        'walletBalance': 200.0,
      }
    };
  }

  Future<Map<String, dynamic>> updateUserName(String name) async {
    // Mock implementation - replace with actual API
    await Future.delayed(const Duration(milliseconds: 800));
    return {'success': true, 'name': name};
  }

  // GAME ENDPOINTS
  Future<List<Map<String, dynamic>>> getMatches({String? category}) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': 'match_001',
        'team1Name': 'MI',
        'team2Name': 'CSK',
        'team1Logo': '',
        'team2Logo': '',
        'matchTime': '08h : 38m',
        'matchDate': 'Monday, 15 Dec',
        'tournament': 'IPL',
        'isLive': false,
      },
    ];
  }

  Future<Map<String, dynamic>> getWalletBalance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'balance': 200.0, 'currency': 'INR'};
  }

  // Save token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
