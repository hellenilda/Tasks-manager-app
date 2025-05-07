import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // IconButton(
              //   onPressed: (){},
              //   icon: Icon(Icons.help)
              // ),
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
                  obscureText: true,
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
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lilas,
                      foregroundColor: AppColors.branco,
                      minimumSize: Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)
                      )
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()) // Redirecionamento para o Home
                      );
                    },
                    child: Text(
                      'Entrar',
                      style: AppTextStyles.p,
                    )
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.lilas,
                    minimumSize: Size(0, 50),
                    side: BorderSide(color: AppColors.lilas),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)
                    )
                  ),
                  onPressed: (){}, 
                  child: Text(
                    'Esqueci a senha',
                    style: AppTextStyles.p,
                  )
                ),
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
      ),
    );
  }
}