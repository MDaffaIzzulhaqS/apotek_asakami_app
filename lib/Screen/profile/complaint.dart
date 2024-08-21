import 'package:apotek_asakami_app/Screen/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() => runApp(UserComplaint());

class UserComplaint extends StatefulWidget {
  UserComplaint({Key? key}) : super(key: key);

  @override
  State<UserComplaint> createState() => _UserComplaintState();
}

class _UserComplaintState extends State<UserComplaint> {
  final CollectionReference _complaint =
      FirebaseFirestore.instance.collection('complaint');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();

  Future<void> addComplaint([DocumentSnapshot? documentSnapshot]) async {
    User? user = FirebaseAuth.instance.currentUser;
    final String name = _nameController.text;
    final String complaint = _complaintController.text;
    if (user != null) {
      // Persist a new product to Firestore
      await _complaint.add({
        'uid': user.uid,
        "name": name,
        "complaint": complaint,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Clear the text fields
      _nameController.text = '';
      _complaintController.text = '';
      // Hide the bottom sheet
      Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () {
          Navigator.of(context).pop();
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const Profile(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu Komplain",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Customer',
                ),
              ),
              TextField(
                controller: _complaintController,
                decoration: const InputDecoration(
                  labelText: 'Jenis Komplain',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      addComplaint();
                    },
                    child: const Text(
                      'Lakukan Komplain',
                      style: TextStyle(
                        fontSize: 16,
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
