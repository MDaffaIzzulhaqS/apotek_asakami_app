import 'package:apotek_asakami_app/Screen/shop/purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');
  // final CollectionReference _checkouts =
  //     FirebaseFirestore.instance.collection('checkouts');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _purchaseMethodController =
      TextEditingController();

  Future<void> _transactionItem() async {
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Center(child: Text("Pembayaran")),
          insetPadding: EdgeInsets.zero,
          content: SizedBox(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 430),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                    ),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Alamat',
                    ),
                  ),
                  TextField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor HP',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Harga',
                    ),
                  ),
                  TextField(
                    controller: _purchaseMethodController,
                    decoration: const InputDecoration(
                      labelText: 'Metode Pembelian',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: const Text('Bayar'),
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        final String name = _nameController.text;
                        final String address = _addressController.text;
                        final String phone = _phoneNumberController.text;
                        final double? price =
                            double.tryParse(_priceController.text);
                        final String purchaseMethod =
                            _purchaseMethodController.text;
                        if (price != null && user != null) {
                          // Persist a new product to Firestore
                          await _transaction.add({
                            'uid': user.uid,
                            "name": name,
                            "address": address,
                            "phone": phone,
                            "price": price,
                            "purchase_method": purchaseMethod,
                            "timestamp": FieldValue.serverTimestamp()
                          });
                          // Clear the text fields
                          _nameController.text = '';
                          _addressController.text = '';
                          _phoneNumberController.text = '';
                          _priceController.text = '';
                          _purchaseMethodController.text = '';
                          // Hide the bottom sheet
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const Purchase(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String datangKeLokasi = "Datang Ke Lokasi";
  String cashOnDelivery = "Cash On Delivery";

  int totalPembelian = 50000;
  int biayaOngkir = 2500;

  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int totalBayar = totalPembelian + biayaOngkir;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Metode Pembayaran",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Pilih Metode Pembayaran Anda",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                        : Border.all(
                            width: 0.3,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                datangKeLokasi,
                                style: _type == 1
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      )
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          ),
                          const Icon(Icons.location_pin),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                        : Border.all(
                            width: 0.3,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                cashOnDelivery,
                                style: _type == 2
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      )
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/logo_asakami.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Pembelian : ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Rp.$totalPembelian,00",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ongkir : ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    _type == 2
                        ? Text(
                            "Rp.$biayaOngkir,00",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )
                        : const Text(
                            "Rp.0,00",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Bayar : ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    _type == 2
                        ? Text(
                            "Rp.$totalBayar,00",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )
                        : Text(
                            "Rp.$totalPembelian,00",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                if (_type == 2)
                  InkWell(
                    onTap: () {
                      _transactionItem();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cash On Delivery",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: () {
                      _transactionItem();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Datang Ke Lokasi",
                            style: TextStyle(
                              color: Colors.white,
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
        ),
      ),
    );
  }
}
