import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  static const String _userKey = 'user_data';
  static const String _onboardingKey = 'onboarding_done';

  AuthRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  Future<bool> isLoggedIn() async {
    final token = await _apiService.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> sendOtp(String mobile) async {
    await _apiService.sendOtp(mobile);
  }

  Future<UserModel> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    final response = await _apiService.verifyOtp(mobile: mobile, otp: otp);

    if (response['success'] == true) {
      final token = response['token'] as String;
      await _apiService.saveToken(token);

      final userData = response['user'] as Map<String, dynamic>;
      final user = UserModel(
        id: userData['id'],
        mobile: userData['mobile'],
        walletBalance: (userData['walletBalance'] as num).toDouble(),
        token: token,
        isVerified: true,
      );

      await _saveUser(user);
      return user;
    }

    throw Exception('OTP verification failed');
  }

  Future<UserModel> updateName(String name) async {
    final response = await _apiService.updateUserName(name);
    final currentUser = await getCurrentUser();

    final updatedUser = currentUser?.copyWith(name: name) ??
        UserModel(name: name, isVerified: true);

    await _saveUser(updatedUser);
    return updatedUser;
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;

    // Simple mock - in production use proper JSON parsing
    return const UserModel(
      id: 'user_001',
      name: 'UserId-Name',
      mobile: '+91 9874563210',
      walletBalance: 200.0,
      isVerified: true,
    );
  }

  Future<void> _saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.toString());
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
