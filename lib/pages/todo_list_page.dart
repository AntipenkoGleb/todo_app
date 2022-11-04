import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';
import '../main.dart';
import 'add_todo_page.dart';
import 'todo_details.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  static const String routeName = '/';

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).todoList),
      ),
      body: ListView.builder(
        itemCount: todoes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              todoes[index],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(index),
            ),
            onTap: () => _details(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _add() async {
    final result = await Navigator.pushNamed(
      context,
      AddTodoPage.routeName,
    );

    if (!mounted || result == null) return;

    setState(() {
      todoes.add(result.toString());
    });
  }

  void _details(int index) async {
    final result = await Navigator.pushNamed(
      context,
      TodoDetailsPage.routeName,
      arguments: index,
    );

    if (!mounted || result == null) return;

    setState(() {
      todoes[index] = result.toString();
    });
  }

  void _delete(int index) {
    setState(() {
      final result = todoes.removeAt(index);
      var snackBar = SnackBar(
        content: Text(S.of(context).todoDeleted(result)),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
