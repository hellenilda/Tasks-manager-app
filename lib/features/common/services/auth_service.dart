import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/auth_result.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';

  // Simulação de base de dados de usuários
  static final List<Map<String, String>> _mockUsers = [
    {
      'id': '1',
      'email': 'admin@email.com',
      'password': '123456',
      'name': 'Administrador',
    },
    {
      'id': '2',
      'email': 'user@email.com',
      'password': 'senha123',
      'name': 'Usuário Teste',
    },
    {
      'id': '3',
      'email': 'hellenilda@email.com',
      'password': 'minhasenha',
      'name': 'Hellenilda',
    },
  ];

  // Método para fazer login
  Future<AuthResult> login(String email, String password) async {
    try {
      // Simula delay de rede
      await Future.delayed(const Duration(milliseconds: 1500));

      // Validações básicas
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.failure('Email e senha são obrigatórios');
      }

      if (!_isValidEmail(email)) {
        return AuthResult.failure('Email inválido');
      }

      if (password.length < 6) {
        return AuthResult.failure('A senha deve ter pelo menos 6 caracteres');
      }

      // Procura o usuário na "base de dados"
      final userData = _mockUsers.firstWhere(
        (user) => user['email']?.toLowerCase() == email.toLowerCase(),
        orElse: () => {},
      );

      if (userData.isEmpty) {
        return AuthResult.failure('Usuário não encontrado');
      }

      if (userData['password'] != password) {
        return AuthResult.failure('Senha incorreta');
      }

      // Cria o objeto usuário
      final user = User(
        id: userData['id']!,
        email: userData['email']!,
        name: userData['name']!,
        createdAt: DateTime.now(),
      );

      // Salva o usuário logado
      await _saveCurrentUser(user);
      
      return AuthResult.success(user, 'Login realizado com sucesso!');
      
    } catch (e) {
      return AuthResult.failure('Erro interno. Tente novamente.');
    }
  }

  // Método para fazer logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Método para verificar se o usuário está logado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Método para obter o usuário atual
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson != null) {
      try {
        final userData = jsonDecode(userJson);
        return User.fromJson(userData);
      } catch (e) {
        return null;
      }
    }
    
    return null;
  }

  // Método simples para registrar um novo usuário
  Future<AuthResult> register(String email, String password, String name) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return AuthResult.failure('Todos os campos são obrigatórios');
      }

      if (!_isValidEmail(email)) {
        return AuthResult.failure('Email inválido');
      }

      if (password.length < 6) {
        return AuthResult.failure('A senha deve ter pelo menos 6 caracteres');
      }

      if (name.trim().length < 2) {
        return AuthResult.failure('Nome deve ter pelo menos 2 caracteres');
      }

      if (name.trim().length > 50) {
        return AuthResult.failure('Nome deve ter no máximo 50 caracteres');
      }

      // Verifica se o nome contém apenas letras, espaços e acentos
      if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(name.trim())) {
        return AuthResult.failure('Nome deve conter apenas letras');
      }

      // Verifica se o email já existe
      final existingUser = _mockUsers.firstWhere(
        (user) => user['email']?.toLowerCase() == email.toLowerCase(),
        orElse: () => {},
      );

      if (existingUser.isNotEmpty) {
        return AuthResult.failure('Este email já está cadastrado');
      }

      // Adiciona novo usuário
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': email.toLowerCase(),
        'password': password,
        'name': name.trim(),
      };
      
      _mockUsers.add(newUser);

      final user = User(
        id: newUser['id']!,
        email: newUser['email']!,
        name: newUser['name']!,
        createdAt: DateTime.now(),
      );

      await _saveCurrentUser(user);

      return AuthResult.success(user, 'Conta criada com sucesso!');
      
    } catch (e) {
      return AuthResult.failure('Erro interno. Tente novamente.');
    }
  }

  // Métodos privados
  Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  // Método para alterar senha
  Future<AuthResult> resetPassword(String email) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      if (email.isEmpty) {
        return AuthResult.failure('Email é obrigatório');
      }

      if (!_isValidEmail(email)) {
        return AuthResult.failure('Email inválido');
      }

      final userData = _mockUsers.firstWhere(
        (user) => user['email']?.toLowerCase() == email.toLowerCase(),
        orElse: () => {},
      );

      if (userData.isEmpty) {
        return AuthResult.failure('Email não encontrado');
      }

      // Lembrete para (futuramente) implementar o envio do email de recuperação
      return AuthResult.success(null, 'Instruções enviadas para seu email');
      
    } catch (e) {
      return AuthResult.failure('Erro interno. Tente novamente.');
    }
  }
}
