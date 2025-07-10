import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/home/home_page.dart';
import 'package:first_app/features/sign_in/signin_controller.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget{
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
                Text(
                  'CADASTRO',
                  style: AppTextStyles.h1,
                ),
                
                // Campo Nome
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40
                  ),
                  child: TextFormField(
                    controller: _controller.nameController,
                    validator: _controller.validateName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Defina um nome de usuário',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                
                // Campo Email
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40
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
                
                // Campo Senha
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40
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
                
                // Campo Confirmar Senha
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40
                  ),
                  child: TextFormField(
                    controller: _controller.confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    validator: _controller.validateConfirmPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Confirme sua senha',
                      prefixIcon: const Icon(Icons.lock_outline),
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
                
                // Botão Cadastrar
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
                          onPressed: _controller.isLoading ? null : _handleRegister,
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
                                  'Cadastrar',
                                  style: AppTextStyles.p,
                                )
                        );
                      },
                    ),
                  ),
                ),
                
                // Botão Cancelar / Voltar
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
                    onPressed: (){
                      Navigator.pop(context); // Volta para a tela de login
                    },
                    child: Text(
                      'Cancelar',
                      style: AppTextStyles.p,
                    )
                  ),
                ),
                
                // Link para Login
                Padding(
                  padding: const EdgeInsets.only(top: 34),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context); // Volta para a tela de login
                    },
                    child: Text(
                      'Já possui uma conta? Faça login',
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
            builder: (context) => HomePage(result.data.email)
          )
        );
      }
    }
  }
}
