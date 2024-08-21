import 'package:apotek_asakami_app/Screen/profile/user_delivery_recap.dart';
import 'package:apotek_asakami_app/Screen/shop/confirm_transaction.dart';
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
  final CollectionReference _delivery =
      FirebaseFirestore.instance.collection('delivery');
  final CollectionReference _checkouts =
      FirebaseFirestore.instance.collection('checkouts');

  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<double> getTotalAmount() async {
    String? userId = await getCurrentUserId();
    double totalPembelian = 0;

    QuerySnapshot querySnapshot =
        await _checkouts.where('uid', isEqualTo: userId).get();
    for (var doc in querySnapshot.docs) {
      totalPembelian += doc['totalPrice'];
    }

    return totalPembelian;
  }

  String bayarSendiri = "Bayar Sendiri";
  String cashOnDelivery = "Cash On Delivery";

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
      body: Expanded(
        child: FutureBuilder<double>(
          future: getTotalAmount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == 0) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              double? totalPembelian = snapshot.data;
              double biayaOngkir = 2500;
              double totalBayar = totalPembelian! + biayaOngkir;
              return Padding(
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
                                      bayarSendiri,
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
                          onTap: () async {
                            User? user = FirebaseAuth.instance.currentUser;
                            final double price = totalPembelian + biayaOngkir;
                            const String purchaseMethod = "Cash On Delivery";
                            const String validation = "Belum Valid";
                            const String status = "Belum Siap";
                            if (user != null) {
                              // Persist a new product to Firestore
                              await _transaction.add({
                                'uid': user.uid,
                                'name': "User 01",
                                'address': "Purwokerto",
                                'phone': "081227086943",
                                "price": price,
                                "purchase_method": purchaseMethod,
                                "valid": validation,
                                "imageUrl": "-",
                                "status": status,
                                "timestamp": FieldValue.serverTimestamp()
                              });
                              await _delivery.add({
                                'uid': user.uid,
                                'name': "User 01",
                                'address': "Purwokerto",
                                'phone': "081227086943",
                                "price": price,
                                "purchase_method": purchaseMethod,
                                "valid": validation,
                                "imageUrl": "-",
                                "status": status,
                                "timestamp": FieldValue.serverTimestamp()
                              });
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.of(context).pop();
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: const UserDeliveryRecap(),
                                  withNavBar: true,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              });
                            }
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
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const ConfirmTransaction(),
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
                              color: Colors.purpleAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bayar Sendiri",
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
              );
            }
          },
        ),
      ),
    );
  }
}
