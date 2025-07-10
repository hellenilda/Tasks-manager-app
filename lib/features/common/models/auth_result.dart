class AuthResult {
  final bool success;
  final String? message;
  final dynamic data;

  AuthResult({
    required this.success,
    this.message,
    this.data,
  });

  factory AuthResult.success([dynamic data, String? message]) {
    return AuthResult(
      success: true,
      data: data,
      message: message,
    );
  }

  factory AuthResult.failure(String message) {
    return AuthResult(
      success: false,
      message: message,
    );
  }
}
