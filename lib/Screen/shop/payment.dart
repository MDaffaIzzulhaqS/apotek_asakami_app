import 'package:flutter/material.dart';

void main() {
  runApp(const Payment());
}

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Halaman Pembayaran'),
      ),
    );
  }
}
