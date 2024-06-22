import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCheckoutRecap extends StatefulWidget {
  const UserCheckoutRecap({super.key});

  @override
  State<UserCheckoutRecap> createState() => _UserCheckoutRecapState();
}

class _UserCheckoutRecapState extends State<UserCheckoutRecap> {
  final CollectionReference _chekouts =
      FirebaseFirestore.instance.collection('checkouts');

  Stream<QuerySnapshot> getUserCheckoutData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _chekouts.where('uid', isEqualTo: user.uid).snapshots();
    } else {
      return const Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Pembelian Pengguna",
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
        child: StreamBuilder<QuerySnapshot>(
          stream: getUserCheckoutData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                Timestamp timestamp = documentSnapshot['timestamp'];
                DateTime dateTime = timestamp.toDate();
                String formattedDate =
                    DateFormat('EEEE, dd-MM-yyyy, HH:mm').format(dateTime);
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: const Text(
                          "Riwayat Pembelian Pengguna",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Nama Produk: "),
                                Text(
                                  documentSnapshot['name'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Jumlah Pembelian: "),
                                Text(
                                  documentSnapshot['totalQuantity'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Total Pembayaran: "),
                                Text(
                                  documentSnapshot['totalPrice'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Waktu Pembelian: "),
                                Text(
                                  formattedDate.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
