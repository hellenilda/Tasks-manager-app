import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      appBar: AppBar(
        title: Align(
          child: Text(
            'BEM VINDO, USER', 
            style: AppTextStyles.h1,
          ),
        ),
        backgroundColor: AppColors.branco,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Altura da borda
          child: Container(
            color: AppColors.azulBordas, // Cor da borda
            height: 1.0, // Espessura da borda
          ),
        ),
      ), 
      drawer: Drawer(
        backgroundColor: AppColors.branco,
        child: Column(
          children: [
            Icon(Icons.person),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20)
            ),
            Text(
              'TAREFAS', 
              style: AppTextStyles.h1,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.azulBordas, // Cor da borda
                    width: 1.0, // Espessura da borda
                  ),
                  borderRadius: BorderRadius.circular(19), // Mesmo valor do shape da SearchBar
                ),
                child: SearchBar(
                  hintText: 'Pesquise sua tarefa...',
                  hintStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(color: AppColors.azulBordas), // Cor da borda da SearchBar
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    AppColors.branco, // Cor de fundo da SearchBar
                  ),
                  elevation: WidgetStateProperty.all<double>(0),
                  trailing: [
                    IconButton(
                      color: AppColors.lilas,
                      icon: Icon(Icons.search, color: AppColors.azulBordas), // Cor do ícone de pesquisa
                      onPressed: () {},
                    ),
                  ],
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.branco,
                  borderRadius: BorderRadius.circular(4)
                ),
                height: 60,
                child: Center(
                  child: Text(
                    'Tarefa', 
                    style: AppTextStyles.p,),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lilas, 
                      foregroundColor: AppColors.branco,
                      minimumSize: Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)
                      )
                    ),
                    onPressed: (){},
                    child: Align(
                      child: Text(
                        'Adicionar', 
                        style: AppTextStyles.p,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}