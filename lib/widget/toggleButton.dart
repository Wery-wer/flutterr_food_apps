import 'package:flutter/material.dart';

class ToggleButtonExample extends StatefulWidget {
  final String text1;
  final String text2;
  final Function(int) onSavedValueChanged;

  const ToggleButtonExample({super.key, 
    required this.text1,
    required this.text2,
    required this.onSavedValueChanged,
  });

  @override
  _ToggleButtonExampleState createState() => _ToggleButtonExampleState();
}

class _ToggleButtonExampleState extends State<ToggleButtonExample> {
  bool isToggled = false;
  int savedValue = 0;

  void toggleButton() {
    // Save the integer value 1 to the variable when the button is pressed
    savedValue = isToggled ? 0 : 1;

    // Toggle the button's state
    setState(() {
      isToggled = !isToggled;
    });

    widget.onSavedValueChanged(savedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: toggleButton,
            style: isToggled
                ? ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 179, 91, 98))
                : ElevatedButton.styleFrom(backgroundColor: const Color(0xffe5737d)),
            child: Text(isToggled ? widget.text1 : widget.text2),
          ),
        ],
      ),
    );
  }
}
