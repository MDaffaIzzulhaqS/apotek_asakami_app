import 'package:flutter/material.dart';

void main() {
  runApp(const BloodSugarCheck());
}

class BloodSugarCheck extends StatelessWidget {
  const BloodSugarCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cek Gula Darah'),
      ),
    );
  }
}
