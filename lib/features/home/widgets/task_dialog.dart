import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task? task; // null para nova tarefa, objeto Task para edição
  final Function(String title, String? description) onSave;

  const TaskDialog({
    super.key,
    this.task,
    required this.onSave,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    
    return AlertDialog(
      backgroundColor: AppColors.branco,
      title: Text(
        isEditing ? 'Editar Tarefa' : 'Nova Tarefa',
        style: AppTextStyles.h1.copyWith(fontSize: 20),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo Título
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título da tarefa',
                  prefixIcon: Icon(Icons.assignment),
                ),
                validator: _validateTitle,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 100,
              ),
              const SizedBox(height: 16),
              
              // Campo Descrição
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição (opcional)',
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 500,
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Botão Cancelar
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: TextStyle(color: AppColors.cinza),
          ),
        ),
        
        // Botão Salvar
        ElevatedButton(
          onPressed: _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lilas,
            foregroundColor: AppColors.branco,
          ),
          child: Text(
            isEditing ? 'Atualizar' : 'Adicionar',
            style: AppTextStyles.p,
          ),
        ),
      ],
    );
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Título é obrigatório';
    }
    if (value.trim().length < 3) {
      return 'Título deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      
      widget.onSave(
        title,
        description.isEmpty ? null : description,
      );
      
      Navigator.of(context).pop();
    }
  }
}
