import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class TodoDetailsPage extends StatefulWidget {
  const TodoDetailsPage({super.key});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.text = ModalRoute.of(context)!.settings.arguments.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).todoDetails),
        actions: [
          IconButton(
            onPressed: _save,
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

  void _save() {
    Navigator.of(context).pop(_controller.text);
  }
}
