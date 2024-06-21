import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const TransactionRecap());
}

class TransactionRecap extends StatefulWidget {
  const TransactionRecap({super.key});

  @override
  State<TransactionRecap> createState() => _TransactionRecapState();
}

class _TransactionRecapState extends State<TransactionRecap> {
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rekap Pembayaran",
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
        stream: _transaction.snapshots(),
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
                          "Rekap Pembayaran",
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
                                const Text("Total Pembelian: "),
                                Text(
                                  documentSnapshot['price'].toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Metode Pembelian: "),
                                Text(
                                  documentSnapshot['purchase_method']
                                      .toString(),
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
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
