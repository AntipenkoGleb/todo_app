import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/pages/add_todo_page.dart';
import 'package:todo_app/pages/todo_details.dart';

import 'generated/l10n.dart';
import 'pages/todo_list_page.dart';

void main() async {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoContainer(
      child: MaterialApp(
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
          AddTodoPage.routeName: (context) => AddTodoPage(),
        },
      ),
    );
  }
}

class TodoContainer extends InheritedWidget {
  final todoes = <String>['Hello'];
  TodoContainer({child, super.key}) : super(child: child);

  static TodoContainer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoContainer>()!;
  }

  @override
  bool updateShouldNotify(TodoContainer oldWidget) {
    return listEquals(todoes, oldWidget.todoes);
  }
}
