import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<void> signInGoogle() async {
    final firebaseAuth = ref.read(firebaseAuthenticationProvider).instance;

    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }
}
