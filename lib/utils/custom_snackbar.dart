import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String content, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2), // Thay đổi thời gian hiển thị nếu cần
    ),
  );
}
