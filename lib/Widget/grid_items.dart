import 'package:apotek_asakami_app/Screen/shop/purchase_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class GridItems extends StatefulWidget {
  const GridItems({super.key});

  @override
  State<GridItems> createState() => _GridItemsState();
}

class _GridItemsState extends State<GridItems> {
  var filter = "";
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: (filter.toString().isNotEmpty)
          ? _productss.where('category', isEqualTo: filter).snapshots()
          : _productss.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return GestureDetector(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const PurchaseDetail(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                ),
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      documentSnapshot['name'],
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
                              documentSnapshot['category'].toString(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Deskripsi Barang : ",
                            ),
                            Text(
                              documentSnapshot['description'].toString(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Jumlah Barang : ",
                            ),
                            Text(
                              documentSnapshot['quantity'].toString(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Harga Barang : ",
                            ),
                            Text(
                              "Rp${documentSnapshot['price']}",
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
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
