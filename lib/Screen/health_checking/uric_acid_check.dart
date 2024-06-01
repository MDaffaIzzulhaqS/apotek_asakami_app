import 'package:flutter/material.dart';

void main() {
  runApp(const UridAcidCheck());
}

class UridAcidCheck extends StatefulWidget {
  const UridAcidCheck({super.key});

  @override
  State<UridAcidCheck> createState() => _UridAcidCheckState();
}

class _UridAcidCheckState extends State<UridAcidCheck> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _uricAcidResult;
  String? _condition;

  void _calculateUricAcid() {
    if (_formKey.currentState!.validate()) {
      double age = double.parse(_ageController.text);
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      // Example calculation (this is a mock formula for demonstration purposes)
      double uricAcid = (age + weight + height) / 3;

      setState(() {
        _uricAcidResult = uricAcid;
        if (uricAcid < 4.0) {
          _condition = "Low";
        } else if (uricAcid >= 4.0 && uricAcid <= 8.5) {
          _condition = "Normal";
        } else {
          _condition = "High";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Asam Urat",
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
                    "Cek Asam Urat",
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
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Umur'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan umur';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _weightController,
                      decoration:
                          const InputDecoration(labelText: 'Berat Badan (kg)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan berat badan';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _heightController,
                      decoration:
                          const InputDecoration(labelText: 'Tinggi Badan (cm)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan tinggi badan';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateUricAcid,
                      child: const Text('Hitung Asam Urat'),
                    ),
                    const SizedBox(height: 20),
                    if (_uricAcidResult != null)
                      Column(
                        children: [
                          Text(
                              'Asam Urat: ${_uricAcidResult!.toStringAsFixed(2)}'),
                          Text('Kondisi: $_condition'),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
