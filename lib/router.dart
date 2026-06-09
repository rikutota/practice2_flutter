import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/home_page.dart';
import 'pages/todo_add.dart';
import 'pages/login_page.dart'; // インポートを追加
import 'providers/auth_provider.dart'; // 前回のauthStateProvider

// Streamの変化をListenable（ChangeNotifier）に変換するための補助クラス
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// router自体もProviderにすることで、内部で他のProvider（認証状態など）を参照できるようにします
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    
    // ログイン状態が変わる（authStateChangesが通知される）たびに、リダイレクト処理を走らせます
    refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => const TodoAdd(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyHomePage(title: 'My Todo App'),
      ),
    ],

    // 画面遷移が発生するとき、または状態が更新されたときに実行されるガード処理
    redirect: (context, state) {
      // 現在のログイン状態を取得（前回のStreamProviderの値を取り出す）
      // ref.readを使用することで、一瞬のデータ取得を行います
      final authState = ref.read(authStateProvider);
      
      // 非同期データがロード中、またはエラーの場合はリダイレクト処理をスキップ
      if (authState.isLoading || authState.hasError) return null;

      final user = FirebaseAuth.instance.currentUser;
      final isLoggingIn = state.matchedLocation == '/login';

      // 1. ログインしていない場合、ログイン画面以外にアクセスしようとしたら強制リダイレクト
      if (user == null) {
        return isLoggingIn ? null : '/login';
      }

      // 2. すでにログインしているのにログイン画面にいる場合、ホーム画面にリダイレクト
      if (isLoggingIn) {
        return '/home';
      }

      // リダイレクトの必要がない場合は null を返す（そのまま目的の画面へ進む）
      return null;
    },
  );
});