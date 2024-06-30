import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const HomeCareRecap());
}

class HomeCareRecap extends StatefulWidget {
  const HomeCareRecap({super.key});

  @override
  State<HomeCareRecap> createState() => _HomeCareRecapState();
}

class _HomeCareRecapState extends State<HomeCareRecap> {
  final CollectionReference _transactionHomecare =
      FirebaseFirestore.instance.collection('transaction_homecare');
  final TextEditingController _statusController = TextEditingController();

  Future<void> updateStatus([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _statusController.text = documentSnapshot['status'];
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
                controller: _statusController,
                decoration:
                    const InputDecoration(labelText: 'Status Pembayaran'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Update'),
                onPressed: () async {
                  final String status = _statusController.text;
                  await _transactionHomecare.doc(documentSnapshot!.id).update({
                    "status": status,
                  });
                  // Clear the text fields
                  _statusController.text = '';
                  // Hide the bottom sheet
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rekap Cek Kesehatan Homecare",
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
        stream: _transactionHomecare.snapshots(),
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
                        title: Row(
                          children: [
                            const Text(
                              "Rekap Cek Kesehatan Homecare",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            Row(
                              children: [
                                // Press this button to edit a single product
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      updateStatus(documentSnapshot),
                                ),
                              ],
                            ),
                          ],
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
