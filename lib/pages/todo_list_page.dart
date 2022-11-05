import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../main.dart';
import 'add_todo_page.dart';
import 'todo_details.dart';

class TodoListPage extends StatelessWidget {
  static const String routeName = '/';

  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoes = context.watch<TodoContainer>().getAll();
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
              onPressed: () => _delete(context, index),
            ),
            onTap: () => _details(context, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _add(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _add(BuildContext context) {
    Navigator.pushNamed(
      context,
      AddTodoPage.routeName,
    );
  }

  void _details(BuildContext context, int index) {
    Navigator.pushNamed(
      context,
      TodoDetailsPage.routeName,
      arguments: index,
    );
  }

  void _delete(BuildContext context, int index) {
    final result = context.read<TodoContainer>().delete(index);
    var snackBar = SnackBar(
      content: Text(S.of(context).todoDeleted(result)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
