import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'TAREFAS', style: AppTextStyles.h1,
          ),
          SearchBar(
            hintText: 'Pesquise sua tarefa...',
          ),
          FilledButton(
            onPressed: (){},
            child: Text('Adicionar')
          )
        ],
      ),
      appBar: AppBar(
        title: Text(
          'Bem vindo, Usuário', style: AppTextStyles.h1,
        )
      )
    );
  }
}