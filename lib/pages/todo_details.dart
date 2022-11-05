import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';

import '../generated/l10n.dart';

class TodoDetailsPage extends StatefulWidget {
  static const String routeName = '/details';

  final int id;

  const TodoDetailsPage({super.key, required this.id});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<TodoContainer>()[widget.id];
  }

  @override
  Widget build(BuildContext context) {
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
    context.read<TodoContainer>().update(widget.id, _controller.text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
