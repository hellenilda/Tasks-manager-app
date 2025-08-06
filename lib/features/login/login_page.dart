import 'package:first_app/features/sign_in/signin_page.dart';
import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/home/home_page.dart';
import 'package:first_app/features/login/login_controller.dart';
import 'package:first_app/features/login/widgets/forgot_password_dialog.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Verifica se o usuário já está logado
    _controller.checkLoginStatus().then((_) {
      if (_controller.currentUser != null) {
        _navigateToHome(_controller.currentUser!);
      }
    });
  }

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
                Text(
                  'LOGIN',
                  style: AppTextStyles.h1,
                ),
                
                // Campo de Email
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20
                  ),
                  child: TextFormField(
                    controller: _controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _controller.validateEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite seu e-mail',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                
                // Campo de Senha
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20
                  ),
                  child: TextFormField(
                    controller: _controller.passwordController,
                    obscureText: _obscurePassword,
                    validator: _controller.validatePassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Digite sua senha',
                      prefixIcon: const Icon(Icons.lock),
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
                  ),
                ),

                // Mensagem de erro
                AnimatedBuilder(
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
                ),
                
                // Botão de Login
                Padding(
                  padding: const EdgeInsets.only(
                    top: 34,
                    bottom: 15
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lilas,
                            foregroundColor: AppColors.branco,
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0)
                            )
                          ),
                          onPressed: _controller.isLoading ? null : _handleLogin,
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
                                  'Entrar',
                                  style: AppTextStyles.p,
                                )
                        );
                      },
                    ),
                  ),
                ),
                
                // Botão Esqueci a Senha
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.lilas,
                      minimumSize: const Size(0, 50),
                      side: BorderSide(color: AppColors.lilas),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)
                      )
                    ),
                    onPressed: _showResetPasswordDialog, 
                    child: Text(
                      'Esqueci a senha',
                      style: AppTextStyles.p,
                    )
                  ),
                ),
                
                // Link para Cadastro
                Padding(
                  padding: const EdgeInsets.only(top: 34),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage()
                        )
                      );
                    },
                    child: Text(
                      'Não possui Login? Cadastre-se',
                      style: AppTextStyles.textButtonUnderlined.copyWith(color: AppColors.cinza)
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final result = await _controller.login();
      
      if (result.success && mounted) {
        _navigateToHome(result.data);
      }
    }
  }

  void _navigateToHome(dynamic user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(user.email, loginController: _controller)
      )
    );
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ForgotPasswordDialog(controller: _controller);
      },
    );
  }
}