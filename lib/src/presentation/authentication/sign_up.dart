import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/controllers/registration_controller.dart';
import 'package:wisy_mobile_challenge/src/presentation/authentication/widgets/form_widgets.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();
  var hidePassword = true;

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
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Header(text: 'Sing up'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingUpButton(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: _formKey,
                    ),
                    FilledButton(
                        onPressed: () => context.router.back(),
                        child: const Text("Go back")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingUpButton extends ConsumerWidget {
  const SingUpButton({
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
      registrationControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      ),
    );

    final signInState = ref.watch(registrationControllerProvider);
    final isLoading = signInState is AsyncLoading<void>;
    return SizedBox(
      width: 120,
      child: FilledButton(
        onPressed: isLoading
            ? null
            : () {
                if (formKey.currentState!.validate()) {
                  ref.read(registrationControllerProvider.notifier).signUp(
                      email: emailController.text,
                      password: passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario creado')),
                  );
                }
              },
        child: isLoading ? loadingWidget : const Text("Sign Up"),
      ),
    );
  }
}
