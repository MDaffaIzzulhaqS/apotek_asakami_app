import 'package:apotek_asakami_app/Screen/admin/main_admin.dart';
import 'package:apotek_asakami_app/Screen/apoteker/apoteker_main.dart';
import 'package:apotek_asakami_app/Screen/auth/auth_register.dart';
import 'package:apotek_asakami_app/Screen/main_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists && userDoc['role'] == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminPage(),
            ),
          );
        } else if (userDoc.exists && userDoc['role'] == 'apoteker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ApotekerPage(),
            ),
          );
        } else if (userDoc.exists && userDoc['role'] == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainMenu(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ada Kesalahan Ketika Login'),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Login: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Halaman Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                "assets/images/logo_asakami.png",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await _login();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum Punya Akun?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Silahkan Registrasi",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: AlertDialog(
                            title: const Text("Konfirmasi"),
                            content: const Text(
                                "Apakah Anda Ingin Keluar Dari Aplikasi?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Tidak"),
                              ),
                              TextButton(
                                onPressed: () {
                                  FlutterExitApp.exitApp();
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
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Keluar Aplikasi",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
