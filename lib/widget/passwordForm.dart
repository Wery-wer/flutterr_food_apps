import 'package:flutter/material.dart';

class passwordForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const passwordForm({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<passwordForm> createState() => _passwordFormState();
}

class _passwordFormState extends State<passwordForm> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(
          // color: Color.fromARGB(255, 0, 0, 0),
          ),
      obscureText: isHide,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: -5),
        // isDense: true,

        filled: true,
        fillColor: const Color.fromARGB(255, 254, 254, 254),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 70),
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        prefixIconColor: const Color.fromARGB(137, 191, 187, 187),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isHide = !isHide;
            });
          },
          child: const Icon(
            Icons.remove_red_eye_outlined,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 70),
        suffixIconColor: const Color.fromARGB(137, 191, 187, 187),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(131, 138, 124, 124), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 247, 220, 220), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
