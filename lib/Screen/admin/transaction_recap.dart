import 'package:flutter/material.dart';

void main() {
  runApp(const TransactionRecap());
}

class TransactionRecap extends StatelessWidget {
  const TransactionRecap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Rekap Transaksi'),
      ),
    );
  }
}
