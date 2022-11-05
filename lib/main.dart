import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/add_todo_page.dart';
import 'package:todo_app/pages/todo_details.dart';

import 'generated/l10n.dart';
import 'pages/todo_list_page.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoContainer()),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).applicationTitle,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateRoute: (settings) {
        if (settings.name == TodoDetailsPage.routeName) {
          final id = settings.arguments as int;

          return MaterialPageRoute(
            builder: (context) => TodoDetailsPage(id: id),
          );
        }

        return null;
      },
      routes: {
        TodoListPage.routeName: (context) => const TodoListPage(),
        AddTodoPage.routeName: (context) => const AddTodoPage(),
      },
    );
  }
}

class TodoContainer extends ChangeNotifier {
  final _todoes = <String>['Hello'];

  void add(String value) {
    _todoes.add(value);
    notifyListeners();
  }

  void update(int index, String value) {
    _todoes[index] = value;
    notifyListeners();
  }

  String delete(int index) {
    var result = _todoes.removeAt(index);
    notifyListeners();
    return result;
  }

  operator [](int index) => _todoes[index];

  List<String> getAll() => List.unmodifiable(_todoes);
}
