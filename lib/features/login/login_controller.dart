import 'package:flutter/material.dart';
import '../common/services/auth_service.dart';
import '../common/models/auth_result.dart';
import '../common/models/user.dart';

class LoginController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  // Controladores dos campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Estados da UI
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  // Método para fazer login
  Future<AuthResult> login() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _authService.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (result.success) {
        _currentUser = result.data as User?;
        _clearFields();
      } else {
        _setError(result.message ?? 'Erro no login');
      }

      return result;
    } catch (e) {
      final errorResult = AuthResult.failure('Erro inesperado. Tente novamente.');
      _setError(errorResult.message!);
      return errorResult;
    } finally {
      _setLoading(false);
    }
  }

  // Método para fazer logout
  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    _clearFields();
    notifyListeners();
  }

  // Método para verificar se já está logado
  Future<void> checkLoginStatus() async {
    if (await _authService.isLoggedIn()) {
      _currentUser = await _authService.getCurrentUser();
      notifyListeners();
    }
  }

  // Método para resetar senha
  Future<AuthResult> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _authService.resetPassword(email.trim());
      
      if (!result.success) {
        _setError(result.message ?? 'Erro ao resetar senha');
      }

      return result;
    } catch (e) {
      final errorResult = AuthResult.failure('Erro inesperado. Tente novamente.');
      _setError(errorResult.message!);
      return errorResult;
    } finally {
      _setLoading(false);
    }
  }

  // Validações
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  // Métodos auxiliares
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  void clearError() {
    _clearError();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}