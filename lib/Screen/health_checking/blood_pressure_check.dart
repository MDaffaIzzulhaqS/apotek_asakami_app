import 'package:flutter/material.dart';

void main() {
  runApp(const BloodPressureCheck());
}

class BloodPressureCheck extends StatefulWidget {
  const BloodPressureCheck({super.key});

  @override
  State<BloodPressureCheck> createState() => _BloodPressureCheckState();
}

class _BloodPressureCheckState extends State<BloodPressureCheck> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  String _result = '';

  void _calculateBloodPressure() {
    final int systolic = int.tryParse(_systolicController.text) ?? 0;
    final int diastolic = int.tryParse(_diastolicController.text) ?? 0;

    String category;

    if (systolic < 120 && diastolic < 80) {
      category = 'Normal';
    } else if (systolic <= 129 && diastolic < 80) {
      category = 'Elevated';
    } else if (systolic <= 139 || diastolic <= 89) {
      category = 'Hypertension Stage 1';
    } else if (systolic >= 140 || diastolic >= 90) {
      category = 'Hypertension Stage 2';
    } else if (systolic >= 180 || diastolic >= 120) {
      category = 'Hypertensive Crisis';
    } else {
      category = 'Invalid Input';
    }

    setState(() {
      _result = 'Category: $category';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Tekanan Darah",
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Cek Tekanan Darah",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Warna garis batas
                width: 2.0, // Ketebalan garis batas
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _systolicController,
                    decoration: const InputDecoration(
                      labelText: 'Systolic (mmHg)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _diastolicController,
                    decoration: const InputDecoration(
                      labelText: 'Diastolic (mmHg)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calculateBloodPressure,
                    child: const Text('Hitung'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
