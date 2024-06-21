import 'package:flutter/material.dart';

void main() {
  runApp(const BloodSugarCheck());
}

class BloodSugarCheck extends StatefulWidget {
  const BloodSugarCheck({super.key});

  @override
  State<BloodSugarCheck> createState() => _BloodSugarCheckState();
}

class _BloodSugarCheckState extends State<BloodSugarCheck> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _calculateResult() {
    final double glucose = double.tryParse(_controller.text) ?? 0.0;
    setState(() {
      _result = _categorizeGlucose(glucose);
    });
  }

  String _categorizeGlucose(double glucose) {
    if (glucose < 70) {
      return 'Gula Darah Rendah';
    } else if (glucose >= 70 && glucose <= 99) {
      return 'Normal';
    } else if (glucose >= 100 && glucose <= 125) {
      return 'Pradiabetes';
    } else if (glucose >= 126) {
      return 'Diabetes';
    } else {
      return 'Invalid Input';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Gula Darah",
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
                    "Cek Gula Darah",
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Masukkan kadar gula darah Anda (mg/dL)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculateResult,
                    child: const Text('Check'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 24),
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
