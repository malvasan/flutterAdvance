import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/auth.dart';

part 'login_controller.g.dart';

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

  //pasar a auth.dart
  Future<void> signInGoogle() async {
    final firebaseAuth = ref.read(firebaseAuthenticationProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await firebaseAuth.signInGoogle();
    });
  }
}
