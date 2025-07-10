import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/login/login_controller.dart';
import 'package:first_app/features/login/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? user;
  final LoginController? controller;

  const HomePage(this.user, {this.controller, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? _concluida = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      appBar: AppBar(
        title: Align(
          child: Text(
            'BEM VINDO, ${(widget.user?.split('@').first ?? 'Usuário').toUpperCase()}!',
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
            // Header do Drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.lilas,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.lilas,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Olá, ${widget.user?.split('@').first ?? 'Usuário'}!',
                    style: AppTextStyles.p.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Opções do menu
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                // Lembrete para implementar uma tela de configurações
              },
            ),
            const Divider(),
            
            // Botão de Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context); // Fecha o drawer
                _showLogoutDialog();
              },
            ),
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
                  child: Row(
                    children: [
                        Checkbox(
                          value: _concluida,
                          onChanged: (bool? val){
                            setState(() {
                              _concluida = val;
                          });
                        }),
                        Text(
                        'Tarefa', 
                        style: AppTextStyles.p,),
                      ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: AppColors.lilas,
        foregroundColor: AppColors.branco,
        child: Icon(Icons.add)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Saída'),
          content: const Text('Tem certeza que deseja sair?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                navigator.pop();
                
                if (widget.controller != null) {
                  await widget.controller!.logout();
                }
                
                if (mounted) {
                  navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }
}