import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import 'add_todo_page.dart';
import 'todo_details.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todoList),
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
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTodoPage(),
      ),
    );

    if (!mounted) return;

    setState(() {
      todoes.add(result);
    });
  }

  void _details(int index) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(arguments: todoes[index]),
        builder: (context) => const TodoDetailsPage(),
      ),
    );

    if (!mounted) return;

    setState(() {
      todoes[index] = result;
    });
  }

  void _delete(int index) {
    setState(() {
      todoes.removeAt(index);
    });
  }
}
