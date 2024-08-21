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
  final TextEditingController _validationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void _updateData(String newValue, [DocumentSnapshot? documentSnapshot]) {
    _transaction.doc(documentSnapshot!.id).update({
      'valid': newValue,
    });
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

  void _updateStatus(String newValue, [DocumentSnapshot? documentSnapshot]) {
    _transaction.doc(documentSnapshot!.id).update({
      'status': newValue,
    });
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
                "Status Obat",
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
                        'Belum Siap',
                        documentSnapshot,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Belum Siap',
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
                      _updateStatus(
                        'Siapkan Obat',
                        documentSnapshot,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Siapkan Obat',
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

  void _removeData(String id) {
    FirebaseFirestore.instance.collection('transaction').doc(id).delete();
  }

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
                String imageUrl = documentSnapshot['imageUrl'];
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Row(
                          children: [
                            const Text(
                              "Rekap Pembayaran",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 45,
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
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _removeData(documentSnapshot.id),
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
                                const Text("Status Obat: "),
                                Text(
                                  documentSnapshot['status'].toString(),
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
                                const Text("Waktu Pembelian: "),
                                Text(
                                  formattedDate.toString(),
                                ),
                              ],
                            ),
                            const Text("Bukti Upload: "),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              alignment: Alignment.center,
                              imageUrl,
                              height: 250,
                              width: 250,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Center(
                                  child: Text(
                                    'Gambar tidak tersedia',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
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
