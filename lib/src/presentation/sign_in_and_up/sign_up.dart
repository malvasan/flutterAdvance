import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/firebase_auth.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignUp> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    onPressed: () => singUp(
                        email: emailController.text,
                        password: passwordController.text),
                    child: const Text("Sign Up")),
                FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Go back")),
              ],
            )
          ],
        ),
      ),
    );
  }

  void singUp({required String email, required String password}) async {
    final authenticator = ref.read(firebaseAuthenticationProvider);
    User? user = await authenticator.signUp(email: email, password: password);
    if (user != null) {
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      log("error sign up");
    }
  }
}
