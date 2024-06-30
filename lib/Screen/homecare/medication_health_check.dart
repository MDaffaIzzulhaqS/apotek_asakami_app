import 'package:apotek_asakami_app/Screen/homecare/homecare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const HomeCareHealthCheck());
}

class HomeCareHealthCheck extends StatefulWidget {
  const HomeCareHealthCheck({super.key});

  @override
  State<HomeCareHealthCheck> createState() => _HomeCareHealthCheckState();
}

class _HomeCareHealthCheckState extends State<HomeCareHealthCheck> {
  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  String cekTekananDarah = "Cek Tekanan Darah";
  String cekAsamUrat = "Cek Asam Urat";
  String cekGulaDarah = "Cek Gula Darah";
  String cekKolesterol = "Cek Kolesterol";

  final CollectionReference _transactionHomecare =
      FirebaseFirestore.instance.collection('transaction_homecare');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();

  Future<void> _transactionItem([DocumentSnapshot? documentSnapshot]) async {
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
                    controller: _serviceController,
                    decoration: const InputDecoration(
                      labelText: 'Jenis Layanan',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: const Text('Konfirmasi'),
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        final String name = _nameController.text;
                        final String address = _addressController.text;
                        final String phone = _phoneNumberController.text;
                        final String service = _serviceController.text;
                        const String status = "Belum Dilayani";
                        if (user != null) {
                          // Persist a new product to Firestore
                          await _transactionHomecare.add({
                            'uid': user.uid,
                            "name": name,
                            "address": address,
                            "phone": phone,
                            "service_type": service,
                            "status": status,
                            "timestamp": FieldValue.serverTimestamp()
                          });
                          // Clear the text fields
                          _nameController.text = '';
                          _addressController.text = '';
                          _phoneNumberController.text = '';
                          _serviceController.text = '';
                          // Hide the bottom sheet
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const HomeCare(),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Kesehatan Home Care",
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
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Pilih Cek Kesehatan Yang Diinginkan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                                cekTekananDarah,
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
                          const Icon(Icons.monitor_heart_rounded),
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
                                cekGulaDarah,
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
                          const Icon(Icons.local_pharmacy_rounded),
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
                    border: _type == 3
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
                                value: 3,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                cekAsamUrat,
                                style: _type == 3
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
                          const Icon(Icons.health_and_safety_rounded),
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
                    border: _type == 4
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
                                value: 4,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor: Colors.black,
                              ),
                              Text(
                                cekKolesterol,
                                style: _type == 4
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
                          const Icon(Icons.local_hospital_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                          "Konfirmasi Cek Kesehatan",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
