import 'package:apotek_asakami_app/Screen/homecare/homecare_consulting.dart';
import 'package:apotek_asakami_app/Screen/homecare/medication_health_check.dart';
import 'package:apotek_asakami_app/Screen/shop/purchase.dart';
import 'package:apotek_asakami_app/Support/models/consultation_model.dart';
import 'package:flutter/material.dart';

class HomeCare extends StatefulWidget {
  const HomeCare({super.key});

  @override
  State<HomeCare> createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Halaman Homecare",
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Layanan Homecare",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.purpleAccent[400],
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Purchase()),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_rounded,
                    size: 20,
                  ),
                  Text(
                    'Beli Obat',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.purpleAccent[400],
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeCareHealthCheck(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_rounded,
                    size: 20,
                  ),
                  Text(
                    'Cek Kesehatan Homecare',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Daftar Dokter Homecare",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: homecareDoctors.length,
              itemBuilder: (context, index) {
                final doctor = homecareDoctors[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(doctor.name),
                    subtitle: Text(doctor.specialty),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        doctor.imageUrl,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeCareConsulting(homecareDoctors: doctor),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
