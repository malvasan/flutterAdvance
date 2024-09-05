import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/auth_controller.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/sign_up.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

//forms *
//no correo mostar error *
//password con astericos y poder verlo *
//circular progress indicator en el sign y snack bar si falla *
//pulirlo
//package gaps para los espacios *

//google auth

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _SignInState();
}

class _SignInState extends ConsumerState<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();

  var hidePassword = true;

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
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log in',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ),
                const Gap(20),
                TextFormField(
                  controller: emailController,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your email',
                  ),
                ),
                const Gap(15),
                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Enter your password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: const Icon(Icons.lock))),
                ),
                const Gap(20),
                LoginButton(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: _formKey,
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      )),
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      loginControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      ),
    );

    final signInState = ref.watch(loginControllerProvider);
    final isLoading = signInState is AsyncLoading<void>;
    return SizedBox(
      width: 120,
      child: FilledButton(
        onPressed: isLoading
            ? null
            : () {
                if (formKey.currentState!.validate()) {
                  ref.read(loginControllerProvider.notifier).signIn(
                      email: emailController.text,
                      password: passwordController.text);
                }
              },
        child: isLoading ? loadingWidget : const Text("Sign In"),
      ),
    );
  }
}
