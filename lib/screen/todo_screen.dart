import 'package:flutter/material.dart';
import 'package:todo_app/screen/widgets/todo_dialog.dart';
import 'package:todo_app/screen/widgets/todo_item.dart';
import 'package:todo_app/utils/custom_snackbar.dart';
import '../models/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  void _addTodo() {
    showDialog(
      context: context,
      builder: (ctx) => TodoDialog(
        onSave: (title, content, imageUrl) {
          setState(() {
            _todos
                .add(Todo(title: title, content: content, imageUrl: imageUrl));
          });
          showCustomSnackBar(
              context, 'Thêm task thành công', Colors.green);
        },
      ),
    );
  }

  void _editTodo(int index) {
    showDialog(
      context: context,
      builder: (ctx) => TodoDialog(
        initialTitle: _todos[index].title,
        initialContent: _todos[index].content,
        initialImageUrl: _todos[index].imageUrl,
        onSave: (title, content, imageUrl) {
          setState(() {
            _todos[index] = Todo(
              title: title,
              content: content,
              imageUrl: imageUrl,
            );
          });
          showCustomSnackBar(
              context, 'Cập nhật task thành công ', Colors.green);
        },
      ),
    );
  }

  void _deleteTodo(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
              setState(() {
                _todos.removeAt(index);
              });
              showCustomSnackBar(
                  context, 'Đã xóa thành công task', Colors.green);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (ctx, index) => TodoItem(
          todo: _todos[index],
          onEdit: () => _editTodo(index),
          onDelete: () => _deleteTodo(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
