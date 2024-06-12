import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductData extends StatefulWidget {
  const ProductData({super.key});
  @override
  ProductDataState createState() => ProductDataState();
}

class ProductDataState extends State<ProductData> {
// text fields' controllers
  var filter = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');

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
                decoration: const InputDecoration(labelText: 'category'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Filter'),
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

// This function is triggered when the floatting button or one of the edit buttons is pressed
// Adding a product if no documentSnapshot is passed
// If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _categoryController.text = documentSnapshot['category'];
      _descriptionController.text = documentSnapshot['description'];
      _quantityController.text = documentSnapshot['quantity'];
      _priceController.text = documentSnapshot['price'].toString();
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Jumlah'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(action == 'create' ? 'Create' : 'Update'),
                onPressed: () async {
                  final String name = _nameController.text;
                  final String category = _categoryController.text;
                  final String description = _descriptionController.text;
                  final String quantity = _quantityController.text;
                  final double? price = double.tryParse(_priceController.text);
                  if (price != null) {
                    if (action == 'create') {
                      // Persist a new product to Firestore
                      await _productss.add({
                        "name": name,
                        "category": category,
                        "description": description,
                        "quantity": quantity,
                        "price": price,
                      });
                    }
                    if (action == 'update') {
                      // Update the product
                      await _productss.doc(documentSnapshot!.id).update({
                        "name": name,
                        "category": category,
                        "description": description,
                        "quantity": quantity,
                        "price": price,
                      });
                    }
                    // Clear the text fields
                    _nameController.text = '';
                    _categoryController.text = '';
                    _descriptionController.text = '';
                    _quantityController.text = '';
                    _priceController.text = '';
                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Hapus Data"),
          content: const Text("Apakah anda yakin?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _productss.doc(productId).delete();
                // Show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil Menghapus Data Produk'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
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
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          documentSnapshot['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            "assets/images/logo_asakami_real.png",
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              documentSnapshot['category'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              documentSnapshot['description'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              documentSnapshot['quantity'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              documentSnapshot['price'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              // Press this button to edit a single product
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot),
                              ),
                              // This icon button is used to delete a single product
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteProduct(documentSnapshot.id),
                              ),
                            ],
                          ),
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
// Add new product
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () => _createOrUpdate(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () => _filter(),
              child: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
