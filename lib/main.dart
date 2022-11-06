import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
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
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => S.of(context).applicationTitle,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: _routes,
    );
  }

  final _routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TodoListPage(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddTodoPage(),
          ),
          GoRoute(
            path: 'details/:id',
            builder: (context, state) => TodoDetailsPage(
              id: int.parse(state.params['id'].toString()),
            ),
          ),
        ],
      )
    ],
  );
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
