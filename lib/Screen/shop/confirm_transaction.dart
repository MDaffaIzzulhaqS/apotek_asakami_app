import 'dart:io';

import 'package:apotek_asakami_app/Screen/profile/user_payment_recap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ConfirmTransaction extends StatefulWidget {
  const ConfirmTransaction({super.key});

  @override
  ConfirmTransactionState createState() => ConfirmTransactionState();
}

class ConfirmTransactionState extends State<ConfirmTransaction> {
  final CollectionReference _checkouts =
      FirebaseFirestore.instance.collection('checkouts');
  final CollectionReference selfTransaction =
      FirebaseFirestore.instance.collection('self_transaction');
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');

  String _transactionStatus = "Belum diproses";

  File? _image;
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<double> getTotalAmount() async {
    String? userId = await getCurrentUserId();
    double totalPembelian = 0;

    QuerySnapshot querySnapshot =
        await _checkouts.where('uid', isEqualTo: userId).get();
    for (var doc in querySnapshot.docs) {
      totalPembelian += doc['totalPrice'];
    }

    return totalPembelian;
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak Ada Gambar Yang Dipilih'),
          ),
        );
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      // Upload image to Firebase Storage
      final storageRef = _storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_image!);
      // Get the download URL
      final downloadURL = await storageRef.getDownloadURL();

      // Store image metadata in Firestore
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _firestore.collection('images').add({
          'uid': user.uid,
          'url': downloadURL,
          'uploadedAt': Timestamp.now(),
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Upload Gambar'),
        ),
      );
      double totalPrice = 30000;
      const String purchaseMethod = "Bayar Sendiri";
      const String validation = "Belum Valid";
      const String status = "Belum Siap";
      if (user != null) {
        // Persist a new product to Firestore
        await _transaction.add(
          {
            'uid': user.uid,
            'name': "User 01",
            'address': "Purwokerto",
            'phone': "081227086943",
            "price": totalPrice,
            "purchase_method": purchaseMethod,
            "valid": validation,
            "imageUrl": downloadURL,
            "status": status,
            "timestamp": FieldValue.serverTimestamp()
          },
        );
      }
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const UserPaymentRecap(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Upload Gambar: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Konfirmasi Pembayaran",
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
      body: Expanded(
        child: FutureBuilder<double>(
          future: getTotalAmount(),
          builder: (context, snapshot) {
            double? price = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nomor Rekening: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "007701100625501",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atas Nama: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Apotek Asakami (BRI)",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Total Bayar: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Rp.$price,00",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _image == null
                      ? const Text('Tidak Ada Gambar Yang Dipilih.')
                      : Image.file(
                          _image!,
                          width: 250,
                          height: 250,
                        ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Pilih Gambar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _image == null
                      ? const Text('Pilih Gambar Dahulu.')
                      : ElevatedButton(
                          onPressed: () async {
                            _uploadImage();
                            _transactionStatus =
                                "Berhasil Melakukan Pembayaran";
                          },
                          child: const Text(
                            'Upload File',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                  const SizedBox(height: 40),
                  Text(
                    'Status Transaksi: $_transactionStatus',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
