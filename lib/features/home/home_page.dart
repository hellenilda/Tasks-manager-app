import 'package:first_app/features/common/constants/app_colors.dart';
import 'package:first_app/features/common/constants/app_text_styles.dart';
import 'package:first_app/features/common/models/user.dart';
import 'package:first_app/features/home/home_controller.dart';
import 'package:first_app/features/home/widgets/task_item.dart';
import 'package:first_app/features/home/widgets/task_dialog.dart';
import 'package:first_app/features/login/login_controller.dart';
import 'package:first_app/features/login/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? userEmail;
  final LoginController? loginController;

  const HomePage(this.userEmail, {this.loginController, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _homeController;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController();
    
    // Criar um objeto User a partir do email
    _currentUser = User(
      id: widget.userEmail?.split('@').first ?? 'user',
      email: widget.userEmail ?? 'user@email.com',
      name: widget.userEmail?.split('@').first ?? 'Usuário',
      createdAt: DateTime.now(),
    );
    
    _homeController.initialize(_currentUser);
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulBg,
      appBar: AppBar(
        title: Align(
          child: Text(
            'BEM VINDO, ${_currentUser.firstName.toUpperCase()}!',
            style: AppTextStyles.h1,
          ),
        ),
        backgroundColor: AppColors.branco,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.azulBordas,
            height: 1.0,
          ),
        ),
      ), 
      drawer: _buildDrawer(),
      body: AnimatedBuilder(
        animation: _homeController,
        builder: (context, child) {
          return Column(
            children: [
              // Título e barra de pesquisa
              _buildHeader(),
              
              // Lista de tarefas
              Expanded(
                child: _homeController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.lilas,
                        ),
                      )
                    : _homeController.tasks.isEmpty
                        ? _buildEmptyState()
                        : _buildTasksList(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: AppColors.lilas,
        foregroundColor: AppColors.branco,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Método para construir o drawer
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.branco,
      child: Column(
        children: [
          // Header do Drawer
          DrawerHeader(
            decoration: const BoxDecoration(
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
                  'Olá, ${_currentUser.firstName}!',
                  style: AppTextStyles.p.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Estatísticas das tarefas
          AnimatedBuilder(
            animation: _homeController,
            builder: (context, child) {
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.azulBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estatísticas',
                      style: AppTextStyles.h1.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('Total', _homeController.totalTasks, AppColors.lilas),
                        _buildStatItem('Concluídas', _homeController.completedTasks, Colors.green),
                        _buildStatItem('Pendentes', _homeController.pendingTasks, Colors.orange),
                      ],
                    ),
                  ],
                ),
              );
            },
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
              // TODO: Implementar tela de configurações
            },
          ),
          const Divider(),
          
          // Botão de Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () async {
              Navigator.pop(context);
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  // Widget para estatísticas
  Widget _buildStatItem(String label, int value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  // Header com título e barra de pesquisa
  Widget _buildHeader() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
        ),
        Text(
          'TAREFAS', 
          style: AppTextStyles.h1,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.azulBordas,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(19),
            ),
            child: SearchBar(
              controller: _homeController.searchController,
              hintText: 'Pesquise sua tarefa...',
              hintStyle: WidgetStateProperty.all<TextStyle>(
                const TextStyle(color: AppColors.azulBordas),
              ),
              textStyle: WidgetStateProperty.all<TextStyle>(
                const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                AppColors.branco,
              ),
              elevation: WidgetStateProperty.all<double>(0),
              onChanged: _homeController.searchTasks,
              leading: _homeController.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.azulBordas),
                      onPressed: _homeController.clearSearch,
                    )
                  : null,
              trailing: [
                IconButton(
                  color: AppColors.lilas,
                  icon: const Icon(Icons.search, color: AppColors.azulBordas),
                  onPressed: () {
                    _homeController.searchTasks(_homeController.searchController.text);
                  },
                ),
              ],
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 16),
              ),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Estado vazio quando não há tarefas
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: AppColors.cinza.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            _homeController.searchQuery.isNotEmpty 
                ? 'Nenhuma tarefa encontrada' 
                : 'Você ainda não tem tarefas',
            style: AppTextStyles.p.copyWith(
              color: AppColors.cinza,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _homeController.searchQuery.isNotEmpty 
                ? 'Tente pesquisar por outro termo' 
                : 'Toque no botão + para adicionar sua primeira tarefa',
            style: TextStyle(
              color: AppColors.cinza.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Lista de tarefas
  Widget _buildTasksList() {
    return ListView.builder(
      itemCount: _homeController.tasks.length,
      itemBuilder: (context, index) {
        final task = _homeController.tasks[index];
        return TaskItem(
          task: task,
          onToggle: () => _homeController.toggleTaskCompletion(task.id),
          onEdit: () => _showEditTaskDialog(task),
          onDelete: () => _showDeleteConfirmation(task),
        );
      },
    );
  }

  // Dialog para adicionar nova tarefa
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        onSave: (title, description) async {
          final success = await _homeController.addTask(title, description);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(success ? 'Tarefa adicionada!' : 'Erro ao adicionar tarefa'),
                backgroundColor: success ? Colors.green : Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  // Dialog para editar tarefa
  void _showEditTaskDialog(task) {
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        task: task,
        onSave: (title, description) async {
          final success = await _homeController.updateTask(task.id, title, description);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(success ? 'Tarefa atualizada!' : 'Erro ao atualizar tarefa'),
                backgroundColor: success ? Colors.green : Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  // Confirmação de exclusão
  void _showDeleteConfirmation(task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir a tarefa "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await _homeController.deleteTask(task.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? 'Tarefa excluída!' : 'Erro ao excluir tarefa'),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
    // Dialog de confirmação de logout
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
                
                if (widget.loginController != null) {
                  await widget.loginController!.logout();
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