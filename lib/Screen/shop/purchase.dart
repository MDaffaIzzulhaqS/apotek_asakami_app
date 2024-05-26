import 'package:apotek_asakami_app/Screen/shop/checkout.dart';
import 'package:apotek_asakami_app/Screen/shop/purchase_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  var filter = "";
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  final TextEditingController _categoryController = TextEditingController();

  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
              child: Text(
                "Penjualan Obat",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: (filter.toString().isNotEmpty)
                    ? _products.where('category', isEqualTo: filter).snapshots()
                    : _products.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data?.docs[index];
                      return GestureDetector(
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: PurchaseDetail(
                            productId: product!.id,
                          ),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              product?['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/logo_asakami_real.png",
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Kategori Barang : ",
                                    ),
                                    Text(
                                      product?['category'],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Deskripsi Barang : ",
                                    ),
                                    Text(
                                      product?['description'],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Jumlah Barang : ",
                                    ),
                                    Text(
                                      product?['quantity'],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Harga Barang : ",
                                    ),
                                    Text(
                                      "Rp${product?['price'].toString()}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () => _filter(),
              child: const Icon(Icons.search),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const Checkout(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: const Icon(Icons.shopping_cart_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _filter() async {
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
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Cari'),
                onPressed: () {
                  setState(() {
                    filter = _categoryController.text;
                    _categoryController.text = '';
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
