import 'package:apotek_asakami_app/Screen/auth/auth_login.dart';
import 'package:apotek_asakami_app/Screen/main_menu.dart';
import 'package:apotek_asakami_app/Screen/queue_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _signOut() async {
    await _auth.signOut();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text(
            "Apakah Anda Ingin Menggunakan Layanan?",
          ),
          actions: [
            TextButton(
              child: const Text("Tidak"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                  (route) => false,
                );
              },
            ),
            TextButton(
              child: const Text("Ya"),
              onPressed: () {
                Navigator.of(context).pop();
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const QueueScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Halaman Konfirmasi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                ElevatedButton(
                  child: const Text("Tampilkan Konfirmasi"),
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Batal"),
                  onPressed: () {
                    _signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
