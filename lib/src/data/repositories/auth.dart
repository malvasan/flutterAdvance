import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/exception/auth_exception.dart';

part 'auth.g.dart';

//error custom en una carpeta

class FirebaseAuthentication {
  FirebaseAuthentication(this.instance);
  final FirebaseAuth instance;

  Future<void> signIn({required String email, required String password}) async {
    try {
      log('called');

      await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(
          type: AuthExceptionType.userNotFound,
          message: 'No user found for that email.',
          error: e,
        );
      } else if (e.code == 'wrong-password') {
        throw AuthException(
          type: AuthExceptionType.wrongPassword,
          message: 'Wrong password provided for that user.',
          error: e,
        );
      }
    } catch (e) {
      throw AuthException(
        type: AuthExceptionType.unknown,
        message: e.toString(),
        error: e,
      );
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        throw AuthException(
          type: AuthExceptionType.weakPassword,
          message: 'The password provided is too weak.',
          error: e,
        );
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        throw AuthException(
          type: AuthExceptionType.emailUsed,
          message: 'The account already exists for that email.',
          error: e,
        );
      }
    } catch (e) {
      throw AuthException(
        type: AuthExceptionType.unknown,
        message: e.toString(),
        error: e,
      );
    }
  }

  Future<void> signInGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = await instance.signInWithCredential(credential);
    } catch (e) {
      throw AuthException(
        type: AuthExceptionType.unknown,
        message: e.toString(),
        error: e,
      );
    }
  }
}

//tener 3 repositorios: auth,
// provider, sign in(devolver user), sign up, funcion(Stream) return User or null que devuelva el estado actual del user(auth state changes), observar la funcion si usuario= MainPage, null=Login
// data base repository, firebase_repositoruy
//
@Riverpod(keepAlive: true)
FirebaseAuthentication firebaseAuthentication(FirebaseAuthenticationRef ref) {
  return FirebaseAuthentication(FirebaseAuth.instance);
}
