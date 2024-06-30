import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const UserHomeCareRecap());
}

class UserHomeCareRecap extends StatefulWidget {
  const UserHomeCareRecap({super.key});

  @override
  State<UserHomeCareRecap> createState() => _UserHomeCareRecapState();
}

class _UserHomeCareRecapState extends State<UserHomeCareRecap> {
  final CollectionReference _transactionHomecare =
      FirebaseFirestore.instance.collection('transaction_homecare');

  Stream<QuerySnapshot> getUserHomecareData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _transactionHomecare.where('uid', isEqualTo: user.uid).snapshots();
    } else {
      return const Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Cek Kesehatan Homecare",
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
      body: StreamBuilder(
        stream: getUserHomecareData(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
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
                          "Riwayat Cek Kesehatan Homecare",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Nama: "),
                                Text(
                                  documentSnapshot['name'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Alamat: "),
                                Text(
                                  documentSnapshot['address'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Nomor Handphone: "),
                                Text(
                                  documentSnapshot['phone'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Layanan: "),
                                Text(
                                  documentSnapshot['service_type'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Waktu Konfirmasi: "),
                                Text(
                                  formattedDate.toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Status: "),
                                Text(
                                  documentSnapshot['status'].toString(),
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
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
