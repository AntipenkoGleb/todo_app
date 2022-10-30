import 'package:flutter/material.dart';

import 'pages/todo_list_page.dart';

final todoes = [
  "Play tennis",
  "Watch films",
];

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo app",
      home: TodoListPage(),
    );
  }
}
