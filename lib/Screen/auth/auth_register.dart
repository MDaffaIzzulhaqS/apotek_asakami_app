import 'package:apotek_asakami_app/Screen/auth/auth_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';
  String username = '';
  String role = '';

  registerUser() async {
    String address = '';
    String phone = '';
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': email,
          'address': address,
          'phone': phone,
          'role': role,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi berhasil!'),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi gagal: ${e.message}'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Halaman Registrasi",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    "assets/images/logo_asakami.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password harus lebih dari 6 karakter';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Role'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Role tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      role = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await registerUser();
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
                          "Registrasi",
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
                      const Text("Sudah Punya Akun?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Silahkan Login",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
