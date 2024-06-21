import 'package:flutter/material.dart';

void main() {
  runApp(const CholesterolCheck());
}

class CholesterolCheck extends StatefulWidget {
  const CholesterolCheck({super.key});

  @override
  State<CholesterolCheck> createState() => _CholesterolCheckState();
}

class _CholesterolCheckState extends State<CholesterolCheck> {
  final TextEditingController _ldlController = TextEditingController();
  final TextEditingController _hdlController = TextEditingController();
  final TextEditingController _triglyceridesController =
      TextEditingController();

  String _result = '';

  void _calculateCholesterol() {
    final double ldl = double.tryParse(_ldlController.text) ?? 0.0;
    final double hdl = double.tryParse(_hdlController.text) ?? 0.0;
    final double triglycerides =
        double.tryParse(_triglyceridesController.text) ?? 0.0;

    // Total Cholesterol = LDL + HDL + (Triglycerides / 5)
    final double totalCholesterol = ldl + hdl + (triglycerides / 5);

    String condition;
    if (totalCholesterol < 200) {
      condition = 'Normal';
    } else if (totalCholesterol >= 200 && totalCholesterol <= 239) {
      condition = 'Batas Tinggi';
    } else {
      condition = 'Tinggi';
    }

    setState(() {
      _result =
          'Total Kolesterol: $totalCholesterol mg/dL\nKondisi: $condition';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Kolesterol",
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
                    "Cek Kolesterol",
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
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Warna garis batas
                width: 2.0, // Ketebalan garis batas
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _ldlController,
                    decoration: const InputDecoration(labelText: 'LDL (mg/dL)'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _hdlController,
                    decoration: const InputDecoration(labelText: 'HDL (mg/dL)'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _triglyceridesController,
                    decoration:
                        const InputDecoration(labelText: 'Trigliserida (mg/dL)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calculateCholesterol,
                    child: const Text('Hitung Kolesterol'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
