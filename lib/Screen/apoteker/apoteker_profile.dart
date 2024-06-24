import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ApotekerProfile());
}

class ApotekerProfile extends StatefulWidget {
  const ApotekerProfile({super.key});

  @override
  State<ApotekerProfile> createState() => _ApotekerProfileState();
}

class _ApotekerProfileState extends State<ApotekerProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Future<DocumentSnapshot> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await _firestore.collection('users').doc(user.uid).get();
    }
    throw Exception("User not logged in");
  }

  Future<void> _updateProfile([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _usernameController.text = documentSnapshot['username'];
      _phoneController.text = documentSnapshot['phone'];
      _addressController.text = documentSnapshot['address'];
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            // prevent the soft keyboard from covering text fields
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'No HP'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Update'),
                onPressed: () async {
                  final String name = _usernameController.text;
                  final String phone = _phoneController.text;
                  final String address = _addressController.text;

                  // Update the profile
                  await _firestore.doc(documentSnapshot!.id).update({
                    "name": name,
                    "phone": phone,
                    "address": address,
                  });

                  // Clear the text fields
                  _usernameController.text = '';
                  _phoneController.text = '';
                  _addressController.text = '';
                  // Hide the bottom sheet
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Data Pengguna Tidak Ditemukan'));
          } else {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(
                      'assets/images/default_profile.png',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  itemProfile(
                    'Nama',
                    userData['username'],
                    Icons.person_rounded,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  itemProfile(
                    'Email',
                    userData['email'],
                    Icons.email_rounded,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  itemProfile(
                    'No Handphone',
                    userData['phone'],
                    Icons.phone_rounded,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  itemProfile(
                    'Alamat',
                    userData['address'],
                    Icons.home_rounded,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple[400],
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () {
                        _updateProfile();
                      },
                      child: const Text(
                        'Ubah Profil',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.deepPurple.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }
}
