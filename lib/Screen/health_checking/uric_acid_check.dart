import 'package:flutter/material.dart';

void main() {
  runApp(const UridAcidCheck());
}

class UridAcidCheck extends StatelessWidget {
  const UridAcidCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cek Asam Urat'),
      ),
    );
  }
}
