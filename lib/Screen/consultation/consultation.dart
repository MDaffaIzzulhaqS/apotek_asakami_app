import 'package:apotek_asakami_app/Screen/consultation/doctor_detail_screen.dart';
import 'package:apotek_asakami_app/Support/models/consultation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Andi Wijaya',
      imageUrl: 'assets/images/default_profile.png',
      specialty: 'Spesialis Anak',
      schedule: 'Senin - Jumat: 09:00 - 15:00',
      description:
          'Dr. Andi Wijaya adalah dokter spesialis anak dengan pengalaman lebih dari 10 tahun.',
    ),
    Doctor(
      name: 'Dr. Budi Santoso',
      imageUrl: 'assets/images/default_profile.png',
      specialty: 'Spesialis Bedah',
      schedule: 'Selasa, Kamis: 10:00 - 14:00',
      description:
          'Dr. Budi Santoso adalah dokter spesialis bedah dengan keahlian dalam operasi minimal invasif.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Halaman Konsultasi",
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
                    "Daftar Dokter Konsultasi",
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
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
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
                              DoctorDetailScreen(doctor: doctor),
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
