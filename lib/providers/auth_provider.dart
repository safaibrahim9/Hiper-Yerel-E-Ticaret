import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _userType;
  Map<String, dynamic>? _userData;
  String? _token;

  // Getters
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get userType => _userType;
  Map<String, dynamic>? get userData => _userData;
  String? get token => _token;

  // TODO: Initialize auth state from local storage
  Future<void> initializeAuth() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString(AppConstants.tokenKey);
      _userType = prefs.getString(AppConstants.userTypeKey);
      
      if (_token != null && _userType != null) {
        _isAuthenticated = true;
        // TODO: Validate token with server
        await _loadUserData();
      }
    } catch (e) {
      debugPrint('Auth initialization error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Customer login
  Future<bool> customerLogin({
    required String phone,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // TODO: Implement API call for customer login
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Simulate successful login
      _userType = AppConstants.userTypeCustomer;
      _isAuthenticated = true;
      _token = 'customer_token_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save to local storage
      await _saveAuthData();
      
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Customer login error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Business login
  Future<bool> businessLogin({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // TODO: Implement API call for business login
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Simulate successful login
      _userType = AppConstants.userTypeBusiness;
      _isAuthenticated = true;
      _token = 'business_token_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save to local storage
      await _saveAuthData();
      
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Business login error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Customer registration
  Future<bool> customerRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // TODO: Implement API call for customer registration
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Simulate successful registration
      _userType = AppConstants.userTypeCustomer;
      _isAuthenticated = true;
      _token = 'customer_token_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save to local storage
      await _saveAuthData();
      
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Customer registration error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Business registration
  Future<bool> businessRegister({
    required String businessName,
    required String category,
    required String address,
    required String phone,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // TODO: Implement API call for business registration
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Simulate successful registration
      _userType = AppConstants.userTypeBusiness;
      _isAuthenticated = true;
      _token = 'business_token_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save to local storage
      await _saveAuthData();
      
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Business registration error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Logout
  Future<void> logout() async {
    _setLoading(true);
    try {
      // TODO: Call logout API if needed
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      // Clear local data
      _isAuthenticated = false;
      _userType = null;
      _userData = null;
      _token = null;
      
      // Clear local storage
      await _clearAuthData();
      
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Load user data
  Future<void> _loadUserData() async {
    try {
      // TODO: Implement API call to get user data
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      // Simulate user data
      _userData = {
        'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
        'name': _userType == AppConstants.userTypeCustomer ? 'Müşteri Adı' : 'İşletme Adı',
        'email': 'user@example.com',
        'phone': '+90 555 123 4567',
        'avatar': null,
      };
      
      notifyListeners();
    } catch (e) {
      debugPrint('Load user data error: $e');
    }
  }

  // TODO: Save auth data to local storage
  Future<void> _saveAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.tokenKey, _token!);
      await prefs.setString(AppConstants.userTypeKey, _userType!);
    } catch (e) {
      debugPrint('Save auth data error: $e');
    }
  }

  // TODO: Clear auth data from local storage
  Future<void> _clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.userTypeKey);
      await prefs.remove(AppConstants.userDataKey);
    } catch (e) {
      debugPrint('Clear auth data error: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
} 