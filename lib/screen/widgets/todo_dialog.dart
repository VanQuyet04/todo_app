import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TodoDialog extends StatefulWidget {
  // 2 field k bắt buộc trong dialog và 1 hàm bắt buộc
  final String? initialTitle;
  final String? initialContent;
  final String? initialImageUrl;
  final Function(String, String, String) onSave;

  const TodoDialog({
    super.key,
    this.initialTitle,
    this.initialContent,
    this.initialImageUrl,
    required this.onSave,
  });

  @override
  State<TodoDialog> createState() => _TodoDialogState();

}

// lớp quản lí trạng thái cho dialog
class _TodoDialogState extends State<TodoDialog> {
  // quản lí tiêu đề dialog
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _imagePath; // đường dẫn của ảnh

  final _picker = ImagePicker();

  // hàm khởi tạo state
  @override
  void initState() {
    super.initState();
    // nếu đã có title thì trả về title cho dialog
    if (widget.initialTitle != null) {
      _titleController.text = widget.initialTitle!;
    }
    // nếu đã có content thì trả về content cho dialog
    if (widget.initialContent != null) {
      _contentController.text = widget.initialContent!;
    }
    // nếu đã chọn ảnh thì trả về đường dẫn cho dialog
    if (widget.initialImageUrl != null) {
      _imagePath = widget.initialImageUrl!;
    }
  }

  // hàm chọn ảnh
  Future<void> _pickImage() async {
    // chờ cho đến khi chọn ảnh xong
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    // chọn xong thì set lại đường dẫn
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  // hàm xác nhận save
  void _submit() {
    final title = _titleController.text;
    final content = _contentController.text;
    final imageUrl = _imagePath ?? '';

    if (title.isEmpty || content.isEmpty || imageUrl.isEmpty) {
      return;
    }

    widget.onSave(title, content, imageUrl);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTitle == null ? 'Add Todo' : 'Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
          const SizedBox(height: 10),
          if (_imagePath != null)
            Image.file(File(_imagePath!),
                width: 100, height: 100, fit: BoxFit.cover),
          TextButton(
            onPressed: _pickImage,
            child: const Text('Pick Image'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
