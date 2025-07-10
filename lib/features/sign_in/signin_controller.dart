import 'package:flutter/material.dart';
import '../common/services/auth_service.dart';
import '../common/models/auth_result.dart';
import '../common/models/user.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  // Controladores dos campos de texto
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Estados da UI
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  // Método para registrar
  Future<AuthResult> register() async {
    _setLoading(true);
    _clearError();

    try {
      // Validação de confirmação de senha
      if (passwordController.text != confirmPasswordController.text) {
        _setError('As senhas não coincidem');
        return AuthResult.failure('As senhas não coincidem');
      }

      final result = await _authService.register(
        emailController.text.trim(),
        passwordController.text,
        nameController.text.trim(),
      );

      if (result.success) {
        _currentUser = result.data as User?;
        _clearFields();
      } else {
        _setError(result.message ?? 'Erro no cadastro');
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
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome é obrigatório';
    }
    if (value.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (value != passwordController.text) {
      return 'As senhas não coincidem';
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
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void clearError() {
    _clearError();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}