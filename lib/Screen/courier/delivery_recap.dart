import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CourierDeliveryOrder());
}

class CourierDeliveryOrder extends StatefulWidget {
  const CourierDeliveryOrder({super.key});

  @override
  State<CourierDeliveryOrder> createState() => _CourierDeliveryOrderState();
}

class _CourierDeliveryOrderState extends State<CourierDeliveryOrder> {
  final CollectionReference _delivery =
      FirebaseFirestore.instance.collection('delivery');
  final TextEditingController _validationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void _updateStatus(String newValue, [DocumentSnapshot? documentSnapshot]) {
    _delivery.doc(documentSnapshot!.id).update({'status': newValue});
  }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Status Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _updateStatus(
                        'Obat Siap',
                        documentSnapshot,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Obat Siap',
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateStatus(
                        'Obat Dikirim',
                        documentSnapshot,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Obat Dikirim',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateData(String newValue, [DocumentSnapshot? documentSnapshot]) {
    _delivery.doc(documentSnapshot!.id).update({'valid': newValue});
  }

  Future<void> updateValidation([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _validationController.text = documentSnapshot['valid'];
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Validasi Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _updateData(
                        'Belum Valid',
                        documentSnapshot,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Belum Valid',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateData(
                        'Sudah Valid',
                        documentSnapshot,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Sudah Valid',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
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
          "Rekap Pengantaran",
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
        stream: _delivery.snapshots(),
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
                              "Rekap Pengantaran",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 90,
                            ),
                            Row(
                              children: [
                                // Press this button to edit a single product
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      updateValidation(documentSnapshot),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.update_rounded),
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
                            Row(
                              children: [
                                const Text("Validasi Pembayaran: "),
                                Text(
                                  documentSnapshot['valid'].toString(),
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
