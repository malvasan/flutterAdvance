import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.emailController,
    required this.textMessage,
    this.autofocus = false,
    this.suffixIcon,
    this.obscureText = false,
  });

  final TextEditingController emailController;
  final String textMessage;
  final bool autofocus;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      autofocus: autofocus,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $textMessage';
        }
        return null;
      },
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: 'Enter your $textMessage',
        suffixIcon: suffixIcon,
      ),
    );
  }
}
