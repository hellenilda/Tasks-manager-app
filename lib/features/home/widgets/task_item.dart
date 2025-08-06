import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.branco,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
          activeColor: AppColors.lilas,
        ),
        title: Text(
          task.title,
          style: AppTextStyles.p.copyWith(
            decoration: task.isCompleted 
                ? TextDecoration.lineThrough 
                : TextDecoration.none,
            color: task.isCompleted 
                ? AppColors.cinza 
                : Colors.black,
          ),
        ),
        subtitle: task.description != null && task.description!.isNotEmpty
            ? Text(
                task.description!,
                style: TextStyle(
                  color: task.isCompleted 
                      ? AppColors.cinza.withValues(alpha: 0.7)
                      : AppColors.cinza,
                  decoration: task.isCompleted 
                      ? TextDecoration.lineThrough 
                      : TextDecoration.none,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.lilas),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
