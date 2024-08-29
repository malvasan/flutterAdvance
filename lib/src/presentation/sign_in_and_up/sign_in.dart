import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/firebase_auth.dart';
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/main_page.dart';
import 'package:wisy_mobile_challenge/src/presentation/sign_in_and_up/sign_up.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
            FilledButton(
                onPressed: () => singIn(
                    email: emailController.text,
                    password: passwordController.text),
                child: const Text("Sign In")),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    )),
                child: const Text("Sign up")),
          ],
        ),
      ),
    );
  }

  void singIn({required String email, required String password}) async {
    final authenticator = ref.read(firebaseAuthenticationProvider);
    User? user = await authenticator.signIn(email: email, password: password);
    if (user != null) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    } else {
      log("error sign in");
    }
  }
}
