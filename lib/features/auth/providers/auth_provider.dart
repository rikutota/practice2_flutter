import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase Authenticationのログイン状態の変更を監視するProvider
// StreamProviderを使うことで、リアルタイムに状態の変化を検知できます
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});