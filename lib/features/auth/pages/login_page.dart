import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false; // ログインと新規登録の切り替え用

  Future<void> _authenticate() async {
    try {
      if (_isSignUp) {
        // 新規登録
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // ログイン
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      if (mounted){
        context.go('/home'); // ログイン成功後にホーム画面へ遷移
      }

      // 成功した場合は、GoRouterのリダイレクト機能が働いて自動的にホーム画面に遷移します
    } on FirebaseAuthException catch (e) {
      // エラーが起きた場合はスナックバーで表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? '認証エラーが発生しました')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isSignUp ? '新規アカウント登録' : 'ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(_isSignUp ? '登録する' : 'ログインする'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                });
              },
              child: Text(_isSignUp ? 'すでにアカウントをお持ちの方はこちら' : '新しくアカウントを作成する'),
            ),
          ],
        ),
      ),
    );
  }
}