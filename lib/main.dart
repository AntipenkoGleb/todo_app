import 'package:flutter/material.dart';

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
        title: const Text("Todo list"),
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
        title: const Text("Todo details"),
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
