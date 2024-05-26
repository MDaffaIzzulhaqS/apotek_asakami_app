import 'package:apotek_asakami_app/Screen/admin/main_admin.dart';
import 'package:apotek_asakami_app/Screen/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerUser(
      String email, String password, String role, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set(
          {
            'username': username,
            'email': email,
            'phone': '',
            'address': '',
            'imageProfileUrl': '',
            'role': role,
          },
        );
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> handleLogin(
      String email, String password, BuildContext context) async {
    User? user = await AuthService().loginUser(email, password);
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      String role = userDoc['role'];
      if (role == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainMenu(),
          ),
        );
      }
    }
  }
}
