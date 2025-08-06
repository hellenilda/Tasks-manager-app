import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/home/home_page.dart';
import 'package:first_app/features/sign_in/signin_controller.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController _controller = SignInController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Título
                Text(
                  'CADASTRO',
                  style: AppTextStyles.h1,
                ),
                
                const SizedBox(height: 20),
                
                // Campo Nome
                _buildTextField(
                  controller: _controller.nameController,
                  validator: _controller.validateName,
                  labelText: 'Defina um nome de usuário',
                  prefixIcon: Icons.person,
                ),
                
                // Campo Email
                _buildTextField(
                  controller: _controller.emailController,
                  validator: _controller.validateEmail,
                  labelText: 'Digite seu e-mail',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                
                // Campo Senha
                _buildTextField(
                  controller: _controller.passwordController,
                  validator: _controller.validatePassword,
                  labelText: 'Digite sua senha',
                  prefixIcon: Icons.lock,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                
                // Campo Confirmar Senha
                _buildTextField(
                  controller: _controller.confirmPasswordController,
                  validator: _controller.validateConfirmPassword,
                  labelText: 'Confirme sua senha',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                // Mensagem de erro
                _buildErrorMessage(),
                
                const SizedBox(height: 34),
                
                // Botão Cadastrar
                _buildActionButton(
                  text: 'Cadastrar',
                  onPressed: _handleRegister,
                  backgroundColor: AppColors.lilas,
                  textColor: AppColors.branco,
                ),
                
                const SizedBox(height: 15),
                
                // Botão Cancelar
                _buildActionButton(
                  text: 'Cancelar',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.lilas,
                  isOutlined: true,
                ),
                
                const SizedBox(height: 34),
                
                // Link para Login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Já possui uma conta? Faça login',
                    style: AppTextStyles.textButtonUnderlined.copyWith(
                      color: AppColors.cinza
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para campos de texto reutilizável
  Widget _buildTextField({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required String labelText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 40,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // Widget para mensagem de erro
  Widget _buildErrorMessage() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.errorMessage != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _controller.errorMessage!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _controller.clearError,
                    iconSize: 20,
                    color: Colors.red.shade700,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Widget para botões de ação reutilizável
  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    bool isOutlined = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (isOutlined) {
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: textColor,
                minimumSize: const Size(0, 50),
                side: BorderSide(color: textColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: AppTextStyles.p,
              ),
            );
          } else {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
                minimumSize: const Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
              onPressed: _controller.isLoading ? null : onPressed,
              child: _controller.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      text,
                      style: AppTextStyles.p,
                    ),
            );
          }
        },
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final result = await _controller.register();
      
      if (result.success && mounted) {
        // Mostra mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message ?? 'Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navega para a HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(result.data.email),
          ),
        );
      }
    }
  }
}
