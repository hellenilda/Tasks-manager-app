import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/login/login_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget{
  const SignInPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'CADASTRO',
                style: AppTextStyles.h1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Defina um nome de usuário'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite seu e-mail'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite sua senha'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirme sua senha'
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
                    onPressed: (){},
                    child: Text(
                      'Criar conta',
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
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage()
                    )
                  );
                }, 
                child: Text(
                  'Cancelar',
                  style: AppTextStyles.p,
                )
              ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(
              //         right: 20
              //       ),
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: AppColors.lilas,
              //           foregroundColor: AppColors.branco,
              //           minimumSize: Size(0, 50),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(9.0)
              //           )
              //         ),
              //         onPressed: (){},
              //         child: Text(
              //           'Entrar',
              //           style: AppTextStyles.p,
              //         )
              //       ),
              //     ),
              //     OutlinedButton(
              //       style: OutlinedButton.styleFrom(
              //         foregroundColor: AppColors.lilas,
              //         minimumSize: Size(0, 50),
              //         side: BorderSide(color: AppColors.lilas),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(9.0)
              //         )
              //       ),
              //       onPressed: (){
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => LoginPage()
              //           )
              //         );
              //       }, 
              //       child: Text(
              //         'Cancelar',
              //         style: AppTextStyles.p,
              //       )
              //     ),
            ],
          )
        ),
      ),
    );
  }  
}