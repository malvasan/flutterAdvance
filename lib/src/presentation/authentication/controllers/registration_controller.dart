import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/auth.dart';

part 'registration_controller.g.dart';

@riverpod
class RegistrationController extends _$RegistrationController {
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
