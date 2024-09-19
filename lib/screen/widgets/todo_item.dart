import 'dart:io'; // Import for using File
import 'package:flutter/material.dart';

import '../../models/todo.dart';

class TodoItem extends StatelessWidget {
  // field bắt buộc trong 1 item
  final Todo todo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(
        File(todo.imageUrl),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(todo.title),
      subtitle: Text(todo.content),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
      onLongPress: onDelete,
    );
  }
}
