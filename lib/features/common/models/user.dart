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
    return name.split(' ').first;
  }
}
