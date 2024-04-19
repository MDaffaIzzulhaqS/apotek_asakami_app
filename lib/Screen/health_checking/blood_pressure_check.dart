import 'package:flutter/material.dart';

void main() {
  runApp(const BloodPressureCheck());
}

class BloodPressureCheck extends StatelessWidget {
  const BloodPressureCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cek Tekanan Darah'),
      ),
    );
  }
}
