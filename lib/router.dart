import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/todo_add.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'Todo List'),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const TodoAdd(),
    ),
  ],
);