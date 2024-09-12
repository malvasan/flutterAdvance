import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/auth.dart';

part 'auth_controller.g.dart';

//auth_providers -> muchos providers en un archivo
//providers locales con varios archivos

@riverpod
Stream<User?> authenticationState(AuthenticationStateRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthenticationProvider).instance;

  return firebaseAuth.authStateChanges();
}
