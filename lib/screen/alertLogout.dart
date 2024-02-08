import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/screen/Main_Page.dart';

class alertLogout extends StatelessWidget {
  const alertLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirmation",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: const Text("Are you sure you want to logout from this account?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                  fontSize: 18),
            )),
        TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 1800),
                  content: Text(
                    'Succesfully logout!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                ),
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
            )),
      ],
    );
  }
}
