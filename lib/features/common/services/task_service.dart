import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskService {
  static const String _tasksKey = 'user_tasks';

  // Obter todas as tarefas do usuário
  Future<List<Task>> getTasks(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getString(_tasksKey);
      
      if (tasksJson != null) {
        final List<dynamic> tasksList = jsonDecode(tasksJson);
        final allTasks = tasksList.map((json) => Task.fromJson(json)).toList();
        
        // Filtrar tarefas do usuário específico
        return allTasks.where((task) => task.userId == userId).toList();
      } else {
        // Se é a primeira vez, criar algumas tarefas de exemplo
        return await _createSampleTasks(userId);
      }
    } catch (e) {
      return [];
    }
  }

  // Criar tarefas de exemplo para novos usuários
  Future<List<Task>> _createSampleTasks(String userId) async {
    final sampleTasks = [
      Task(
        id: '${DateTime.now().millisecondsSinceEpoch}1',
        title: 'Bem-vindo ao seu gerenciador de tarefas!',
        description: 'Esta é uma tarefa de exemplo. Você pode editá-la ou excluí-la.',
        isCompleted: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        userId: userId,
      ),
      Task(
        id: '${DateTime.now().millisecondsSinceEpoch}2',
        title: 'Explorar funcionalidades',
        description: 'Teste adicionar, editar, completar e excluir tarefas.',
        isCompleted: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        userId: userId,
      ),
      Task(
        id: '${DateTime.now().millisecondsSinceEpoch}3',
        title: 'Tarefa concluída de exemplo',
        description: 'Esta tarefa já está marcada como concluída.',
        isCompleted: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        completedAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        userId: userId,
      ),
    ];

    // Salvar tarefas de exemplo
    final allTasks = await _getAllTasks();
    allTasks.addAll(sampleTasks);
    await _saveTasks(allTasks);
    
    return sampleTasks;
  }

  // Salvar uma nova tarefa
  Future<bool> addTask(Task task) async {
    try {
      final tasks = await _getAllTasks();
      tasks.add(task);
      return await _saveTasks(tasks);
    } catch (e) {
      return false;
    }
  }

  // Atualizar uma tarefa existente
  Future<bool> updateTask(Task updatedTask) async {
    try {
      final tasks = await _getAllTasks();
      final index = tasks.indexWhere((task) => task.id == updatedTask.id);
      
      if (index != -1) {
        tasks[index] = updatedTask;
        return await _saveTasks(tasks);
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  // Deletar uma tarefa
  Future<bool> deleteTask(String taskId) async {
    try {
      final tasks = await _getAllTasks();
      tasks.removeWhere((task) => task.id == taskId);
      return await _saveTasks(tasks);
    } catch (e) {
      return false;
    }
  }

  // Alternar status de conclusão de uma tarefa
  Future<bool> toggleTaskCompletion(String taskId) async {
    try {
      final tasks = await _getAllTasks();
      final index = tasks.indexWhere((task) => task.id == taskId);
      
      if (index != -1) {
        final task = tasks[index];
        final updatedTask = task.copyWith(
          isCompleted: !task.isCompleted,
          completedAt: !task.isCompleted ? DateTime.now() : null,
        );
        tasks[index] = updatedTask;
        return await _saveTasks(tasks);
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  // Buscar tarefas por título
  Future<List<Task>> searchTasks(String userId, String query) async {
    try {
      final tasks = await getTasks(userId);
      if (query.trim().isEmpty) {
        return tasks;
      }
      
      return tasks.where((task) =>
          task.title.toLowerCase().contains(query.toLowerCase()) ||
          (task.description?.toLowerCase().contains(query.toLowerCase()) ?? false)
      ).toList();
    } catch (e) {
      return [];
    }
  }

  // Métodos auxiliares privados
  Future<List<Task>> _getAllTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getString(_tasksKey);
      
      if (tasksJson != null) {
        final List<dynamic> tasksList = jsonDecode(tasksJson);
        return tasksList.map((json) => Task.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> _saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
      return await prefs.setString(_tasksKey, tasksJson);
    } catch (e) {
      return false;
    }
  }
}
