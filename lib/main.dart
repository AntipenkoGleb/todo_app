import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/pages/add_todo_page.dart';
import 'package:todo_app/pages/todo_details.dart';

import 'generated/l10n.dart';
import 'pages/todo_list_page.dart';

final todoes = [
  "Play tennis",
  "Watch films",
];

void main() async {
  runApp(const TodoApp());
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
      routes: {
        TodoListPage.routeName: (context) => const TodoListPage(),
        AddTodoPage.routeName: (context) => AddTodoPage(),
        TodoDetailsPage.routeName: (context) => const TodoDetailsPage(),
      },
    );
  }
}
