import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/screen/Main_Page.dart';

class logout extends StatefulWidget {
  const logout({super.key});

  @override
  State<logout> createState() => _logoutState();
}

class _logoutState extends State<logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 245,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffe5737d),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(14)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Text Ririn Marinka
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "Rinrin Marinka",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF000000),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: const Text(
                    "Anda Telah ",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 30,
                          color: Color(0xFF676767),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 36,
                      color: Color(0xFF000000),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 30,
                          color: Color(0xFF676767),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 36,
                      color: Color(0xFF000000),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            // BOX OK
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color(0xffe5737d), // Ubah warna teks
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.84),
                  ),
                  minimumSize: const Size(260, 57.96),
                ),
                child: const Text('OK'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
