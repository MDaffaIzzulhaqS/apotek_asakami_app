import 'package:flutter/material.dart';

class HomeCareHealthCheck extends StatefulWidget {
  const HomeCareHealthCheck({super.key});

  @override
  State<HomeCareHealthCheck> createState() => _HomeCareHealthCheckState();
}

class _HomeCareHealthCheckState extends State<HomeCareHealthCheck> {
  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Text('Halaman Cek Kesehatan HomeCare'),
      ),
    );
  }
}
