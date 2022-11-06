import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../main.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  static const String routeName = '/add';

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addTodo),
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
    context.read<TodoContainer>().add(_controller.text);
    context.pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
