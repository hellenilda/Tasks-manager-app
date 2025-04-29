import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      body: Center(
        child: Column(
          children: [
            Text(
              'LOGIN',
              style: AppTextStyles.h1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite seu e-mail'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite sua senha'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 34,
                bottom: 15
              ),
              child: ElevatedButton(
                onPressed: (){}, 
                child: Text(
                  'Entrar'
                )
              ),
            ),
            OutlinedButton(
              onPressed: (){}, 
              child: Text(
                'Esqueci a senha'
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 34),
              child: TextButton(
                onPressed: (){},
                child: Text(
                  'Não possui Login? Cadastre-se',
                  style: AppTextStyles.textButtonUnderlined.copyWith(color: AppColors.cinza)
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}