import 'package:apotek_asakami_app/Support/models/consultation_model.dart';
import 'package:flutter/material.dart';

class HomeCareConsulting extends StatefulWidget {
  final Doctor doctor;
  const HomeCareConsulting({super.key, required this.doctor});

  @override
  State<HomeCareConsulting> createState() => _HomeCareConsultingState();
}

class _HomeCareConsultingState extends State<HomeCareConsulting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Dokter HomeCare",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.doctor.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Nama: ${widget.doctor.name}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Spesialis: ${widget.doctor.specialty}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Jadwal: ${widget.doctor.schedule}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.doctor.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple[400],
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  // _bookingDoctor();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_rounded,
                      size: 20,
                    ),
                    Text(
                      'Buat Janji Konsultasi',
                      style: TextStyle(
                        fontSize: 16,
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
}
