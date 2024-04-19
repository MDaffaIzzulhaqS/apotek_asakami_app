import 'package:flutter/material.dart';

class HomeCare extends StatefulWidget {
  const HomeCare({super.key});

  @override
  State<HomeCare> createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Halaman HomeCare'),
      ),
    );
  }
}