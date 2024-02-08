import 'package:flutter/material.dart';

class loginForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const loginForm({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(
          // color: Color.fromARGB(255, 0, 0, 0),
          ),
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 18), //Change this value to custom as you like
        // isDense: true,

        filled: true,
        fillColor: const Color.fromARGB(255, 254, 254, 254),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 70),
        prefixIcon: const Icon(Icons.email_outlined),
        prefixIconColor: const Color.fromARGB(137, 191, 187, 187),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(131, 138, 124, 124), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(249, 247, 220, 220), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
