import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

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
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    } catch (e) {
      log(e.toString());
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
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
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
