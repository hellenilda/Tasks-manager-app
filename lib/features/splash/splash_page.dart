import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradienteRosa,
          ),
        ),
        child: Text(
          'Financy',
          style: AppTextStyles.textoGrande.copyWith(color: AppColors.branco),
        ),
      ),
    );
  }
}