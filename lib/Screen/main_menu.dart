import 'package:apotek_asakami_app/Screen/auth/auth_login.dart';
import 'package:apotek_asakami_app/Widget/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainMenu());
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apotek Asakami",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/logo_asakami_real.png",
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: const Text(
                            "Apakah Anda Ingin Logout Dari Aplikasi?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Tidak"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text("Ya"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: const BottomNavBar(),
    );
  }

  _signOut() async {
    await _auth.signOut();
  }
}
