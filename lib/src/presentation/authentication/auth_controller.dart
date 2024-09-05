import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/auth.dart';

part 'auth_controller.g.dart';

@riverpod
Stream<User?> authenticationState(AuthenticationStateRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthenticationProvider).instance;

  return firebaseAuth.authStateChanges();
}

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    final firebaseAuth = ref.read(firebaseAuthenticationProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await firebaseAuth.signIn(email: email, password: password);
    });
  }
}

@riverpod
class RegistrationController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> signUp({required String email, required String password}) async {
    final firebaseAuth = ref.read(firebaseAuthenticationProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await firebaseAuth.signUp(email: email, password: password);
    });
  }
}
