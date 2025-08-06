import 'package:flutter/material.dart';
import '../common/models/task.dart';
import '../common/models/user.dart';
import '../common/services/task_service.dart';

class HomeController extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = false;
  String _searchQuery = '';
  User? _currentUser;

  // Getters
  List<Task> get tasks => _filteredTasks;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  User? get currentUser => _currentUser;

  // Controladores de texto
  final TextEditingController searchController = TextEditingController();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();

  // Inicializar o controlador com o usuário atual
  void initialize(User user) {
    _currentUser = user;
    loadTasks();
  }

  // Carregar tarefas do usuário
  Future<void> loadTasks() async {
    if (_currentUser == null) return;
    
    _setLoading(true);
    try {
      _tasks = await _taskService.getTasks(_currentUser!.id);
      _applyFilter();
    } catch (e) {
      debugPrint('Erro ao carregar tarefas: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Adicionar nova tarefa
  Future<bool> addTask(String title, String? description) async {
    if (_currentUser == null || title.trim().isEmpty) return false;

    _setLoading(true);
    try {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
        description: description?.trim(),
        isCompleted: false,
        createdAt: DateTime.now(),
        userId: _currentUser!.id,
      );

      final success = await _taskService.addTask(newTask);
      if (success) {
        await loadTasks();
        _clearTaskFields();
      }
      return success;
    } catch (e) {
      debugPrint('Erro ao adicionar tarefa: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Atualizar tarefa existente
  Future<bool> updateTask(String taskId, String title, String? description) async {
    if (title.trim().isEmpty) return false;

    _setLoading(true);
    try {
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex == -1) return false;

      final updatedTask = _tasks[taskIndex].copyWith(
        title: title.trim(),
        description: description?.trim(),
      );

      final success = await _taskService.updateTask(updatedTask);
      if (success) {
        await loadTasks();
      }
      return success;
    } catch (e) {
      debugPrint('Erro ao atualizar tarefa: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Alternar status de conclusão da tarefa
  Future<bool> toggleTaskCompletion(String taskId) async {
    try {
      final success = await _taskService.toggleTaskCompletion(taskId);
      if (success) {
        await loadTasks();
      }
      return success;
    } catch (e) {
      debugPrint('Erro ao alternar status da tarefa: $e');
      return false;
    }
  }

  // Deletar tarefa
  Future<bool> deleteTask(String taskId) async {
    _setLoading(true);
    try {
      final success = await _taskService.deleteTask(taskId);
      if (success) {
        await loadTasks();
      }
      return success;
    } catch (e) {
      debugPrint('Erro ao deletar tarefa: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Pesquisar tarefas
  void searchTasks(String query) {
    _searchQuery = query;
    _applyFilter();
  }

  // Limpar pesquisa
  void clearSearch() {
    _searchQuery = '';
    searchController.clear();
    _applyFilter();
  }

  // Aplicar filtro de pesquisa
  void _applyFilter() {
    if (_searchQuery.trim().isEmpty) {
      _filteredTasks = List.from(_tasks);
    } else {
      _filteredTasks = _tasks.where((task) =>
          task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (task.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      ).toList();
    }
    notifyListeners();
  }

  // Métodos auxiliares
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _clearTaskFields() {
    taskTitleController.clear();
    taskDescriptionController.clear();
  }

  // Validações
  String? validateTaskTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Título é obrigatório';
    }
    if (value.trim().length < 3) {
      return 'Título deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  // Estatísticas das tarefas
  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;

  @override
  void dispose() {
    searchController.dispose();
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }
}
