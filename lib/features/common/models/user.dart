class User {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  // Construtor para criar um usuário a partir de JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Método para converter o usuário em JSON (persistência)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Método para extrair o primeiro nome do usuário
  String get firstName {
    final parts = name.trim().split(' ');
    return parts.isNotEmpty ? parts.first : name;
  }

  // Método para extrair o último nome do usuário
  String get lastName {
    final parts = name.trim().split(' ');
    return parts.length > 1 ? parts.last : '';
  }

  // Método para obter as iniciais do nome
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'.toUpperCase();
  }
}
