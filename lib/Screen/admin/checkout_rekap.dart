import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CheckoutRecap());
}

class CheckoutRecap extends StatefulWidget {
  const CheckoutRecap({super.key});

  @override
  State<CheckoutRecap> createState() => _CheckoutRecapState();
}

class _CheckoutRecapState extends State<CheckoutRecap> {
  final CollectionReference _checkouts =
      FirebaseFirestore.instance.collection('checkouts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _checkouts.snapshots(),
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
                          "Rekap Pembelian",
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
                                const Text("Total Pembyaran: "),
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
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
