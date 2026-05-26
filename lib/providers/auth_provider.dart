import 'package:flutter/foundation.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  String? _errorMessage;
  String? _mobile;

  AuthProvider({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  String? get mobile => _mobile;
  bool get isLoading => _status == AuthStatus.loading;

  Future<void> checkAuthStatus() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final isLoggedIn = await _repository.isLoggedIn();
      if (isLoggedIn) {
        _user = await _repository.getCurrentUser();
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }

    notifyListeners();
  }

  Future<bool> sendOtp(String mobile) async {
    _setLoading();
    _mobile = mobile;

    try {
      await _repository.sendOtp(mobile);
      // ✅ Reset status so isLoading = false after API call
      _status = AuthStatus.unauthenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    if (_mobile == null) {
      _setError('Mobile number not set');
      return false;
    }

    _setLoading();

    try {
      _user = await _repository.verifyOtp(
        mobile: _mobile!,
        otp: otp,
      );
      // ✅ FIX: was calling _clearError() which never changed _status,
      //    so isLoading stayed true and navigation never triggered.
      _status = AuthStatus.unauthenticated; // not fully onboarded yet
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> saveName(String name) async {
    _setLoading();

    try {
      _user = await _repository.updateName(name);
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    _mobile = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message.replaceAll('Exception: ', '');
    notifyListeners();
  }
}