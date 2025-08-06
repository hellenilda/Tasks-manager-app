import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../login_controller.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final LoginController controller;

  const ForgotPasswordDialog({
    super.key,
    required this.controller,
  });

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.branco,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.lock_reset,
            color: AppColors.lilas,
            size: 28,
          ),
          const SizedBox(width: 8),
          Text(
            'Recuperar Senha',
            style: AppTextStyles.h1.copyWith(fontSize: 20),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Digite seu email para receber as instruções de recuperação de senha:',
                style: AppTextStyles.p.copyWith(
                  color: AppColors.cinza,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: AppColors.lilas),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lilas),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.azulBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.azulBordas),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.lilas,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Você receberá um email com as instruções para redefinir sua senha.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.cinza.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancelar',
            style: TextStyle(color: AppColors.cinza),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handlePasswordReset,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lilas,
            foregroundColor: AppColors.branco,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'Enviar',
                  style: AppTextStyles.p,
                ),
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  Future<void> _handlePasswordReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final result = await widget.controller.resetPassword(email);
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  result.success ? Icons.check_circle : Icons.error,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    result.message ?? 'Operação realizada',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: result.success ? Colors.green : Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }
}
