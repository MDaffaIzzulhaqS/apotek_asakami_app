import 'package:flutter/material.dart';

class DeliveryOrder extends StatefulWidget {
  const DeliveryOrder({super.key});

  @override
  State<DeliveryOrder> createState() => DeliveryOrderState();
}

class DeliveryOrderState extends State<DeliveryOrder> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Halaman Delivery Order'),
      ),
    );
  }
}