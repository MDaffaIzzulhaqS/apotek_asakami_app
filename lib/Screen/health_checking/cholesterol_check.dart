import 'package:flutter/material.dart';

void main() {
  runApp(const CholesterolCheck());
}

class CholesterolCheck extends StatelessWidget {
  const CholesterolCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cek Kolesterol'),
      ),
    );
  }
}
