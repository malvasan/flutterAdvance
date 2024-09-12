import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/sign_up.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/controllers/login_controller.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

import 'widgets/form_widgets.dart';

//forms *
//no correo mostar error *
//password con astericos y poder verlo *
//circular progress indicator en el sign y snack bar si falla *
//pulirlo
//package gaps para los espacios *

//google auth
//imagenes un loading cuando estan loading(no flicker) *

//refactorizar codigo duplicado, dentro de authentication/widgets(locales)/ dentro de la carpeta
//

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
                const Header(
                  text: 'Log in',
                ),
                const Gap(20),
                CustomFormField(
                  emailController: emailController,
                  textMessage: 'email',
                  autofocus: true,
                ),
                const Gap(15),
                CustomFormField(
                  emailController: passwordController,
                  textMessage: 'password',
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      hidePassword = !hidePassword;
                      setState(() {});
                    },
                    icon: const Icon(Icons.lock),
                  ),
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
                SizedBox(
                  width: 120,
                  child: IconButton(
                    onPressed: () {
                      ref.read(loginControllerProvider.notifier).signInGoogle();
                    },
                    icon: Image.asset(
                      'lib/src/presentation/authentication/src/colourful-google-logo-on-white-background-free-vector.jpg',
                    ),
                  ),
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
    final isLoading = signInState.isLoading;
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
