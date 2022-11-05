import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

import '../generated/l10n.dart';

class TodoDetailsPage extends StatelessWidget {
  static const String routeName = '/details';

  final int id;

  final _controller = TextEditingController();

  TodoDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final todo = TodoContainer.of(context).todoes[id];
    _controller.text = todo;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).todoDetails),
        actions: [
          IconButton(
            onPressed: () => _save(context),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  void _save(BuildContext context) {
    Navigator.of(context).pop(_controller.text);
  }
}
