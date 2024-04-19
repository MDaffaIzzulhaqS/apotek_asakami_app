import 'package:flutter/material.dart';

void main() {
  runApp(const FullCheck());
}

class FullCheck extends StatelessWidget {
  const FullCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cek Lengkap'),
      ),
    );
  }
}
