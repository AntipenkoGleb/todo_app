import 'package:flutter/material.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add todo"),
        actions: [
          IconButton(
            onPressed: () => _save(context),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          controller: _controller,
          autofocus: true,
          maxLines: null,
        ),
      ),
    );
  }

  void _save(BuildContext context) {
    Navigator.of(context).pop(_controller.text);
  }
}
