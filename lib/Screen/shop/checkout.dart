import 'package:apotek_asakami_app/Screen/shop/payment.dart';
import 'package:apotek_asakami_app/Screen/shop/purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const Checkout());
}

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final CollectionReference _chekouts =
      FirebaseFirestore.instance.collection('checkouts');

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();

  // Future<void> _updateCheckout([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     _nameController.text = documentSnapshot['name'];
  //     _quantityController.text = documentSnapshot['quantity'];
  //     _priceController.text = documentSnapshot['price'].toString();
  //   }
  //   await showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext ctx) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           top: 20,
  //           left: 20,
  //           right: 20,
  //           // prevent the soft keyboard from covering text fields
  //           bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             TextField(
  //               controller: _nameController,
  //               decoration: const InputDecoration(labelText: 'Nama'),
  //             ),
  //             TextField(
  //               controller: _quantityController,
  //               decoration: const InputDecoration(labelText: 'Jumlah'),
  //             ),
  //             TextField(
  //               keyboardType:
  //                   const TextInputType.numberWithOptions(decimal: true),
  //               controller: _priceController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Harga',
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             ElevatedButton(
  //               child: const Text("Update"),
  //               onPressed: () async {
  //                 final String name = _nameController.text;
  //                 final String quantity = _quantityController.text;
  //                 final double? price = double.tryParse(_priceController.text);
  //                 if (price != null) {
  //                   await _chekouts.doc(documentSnapshot!.id).update({
  //                     "name": name,
  //                     "quantity": quantity,
  //                     "price": price,
  //                   });
  //                 }
  //                 // Clear the text fields
  //                 _nameController.text = '';
  //                 _quantityController.text = '';
  //                 _priceController.text = '';
  //                 // Hide the bottom sheet
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _deleteCheckout(String productId) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Hapus Data"),
          content: const Text("Apakah anda yakin?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _chekouts.doc(productId).delete();
                // Show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil Menghapus Data Checkout'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tidak'),
            )
          ],
        );
      },
    );
  }

  Future<void> _completeCheckout(String productId) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Bayar"),
          content: const Text("Apakah anda yakin?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _chekouts.doc(productId).delete();
                // Show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil Melakukan Pembayaran'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tidak'),
            )
          ],
        );
      },
    );
  }

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
          "Checkout Barang",
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
        child: StreamBuilder(
          stream: getUserCheckoutData(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final data = snapshot.requireData;
            if (data.docs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        "Silahkan Pilih Barang Dahulu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const Purchase(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag_rounded),
                              Text(
                                "Pilih Barang Disini",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var product = data.docs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Nama Barang: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        product['name'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Jumlah Barang: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        product['totalQuantity'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Harga Barang: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        product['totalPrice'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 90,
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // _updateCheckout();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteCheckout(product.id);
                                },
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const Payment(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money_rounded),
                          Text(
                            "Bayar",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
