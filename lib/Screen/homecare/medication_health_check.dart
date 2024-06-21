import 'package:flutter/material.dart';

void main() {
  runApp(const HomeCareHealthCheck());
}

class HomeCareHealthCheck extends StatefulWidget {
  const HomeCareHealthCheck({super.key});

  @override
  State<HomeCareHealthCheck> createState() => _HomeCareHealthCheckState();
}

class _HomeCareHealthCheckState extends State<HomeCareHealthCheck> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _ldlController = TextEditingController();
  final TextEditingController _hdlController = TextEditingController();
  final TextEditingController _triglyceridesController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _uricAcidResult;
  String? _condition;
  String _bloodpressureresult = '';
  String _glucoseresult = '';
  String _cholesterolresult = '';

  void _calculateBloodPressure() {
    final int systolic = int.tryParse(_systolicController.text) ?? 0;
    final int diastolic = int.tryParse(_diastolicController.text) ?? 0;

    String category;

    if (systolic < 120 && diastolic < 80) {
      category = 'Normal';
    } else if (systolic <= 129 && diastolic < 80) {
      category = 'Tinggi';
    } else if (systolic <= 139 || diastolic <= 89) {
      category = 'Hipertensi Stadium 1';
    } else if (systolic >= 140 || diastolic >= 90) {
      category = 'Hipertensi Stadium 2';
    } else if (systolic >= 180 || diastolic >= 120) {
      category = 'Hipertensi Kritis';
    } else {
      category = 'Invalid Input';
    }

    setState(() {
      _bloodpressureresult = 'Kategori: $category';
    });
  }

  void _calculateResult() {
    final double glucose = double.tryParse(_controller.text) ?? 0.0;
    setState(() {
      _glucoseresult = _categorizeGlucose(glucose);
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
      _cholesterolresult =
          'Total Kolesterol: $totalCholesterol mg/dL\nKondisi: $condition';
    });
  }

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
          _condition = "Rendah";
        } else if (uricAcid >= 4.0 && uricAcid <= 8.5) {
          _condition = "Normal";
        } else {
          _condition = "Tinggi";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Kesehatan Home Care",
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
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
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
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Warna garis batas
                        width: 2.0, // Ketebalan garis batas
                      ),
                    ),
                    child: bloodPressure(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Warna garis batas
                    width: 2.0, // Ketebalan garis batas
                  ),
                ),
                child: bloodSugar(),
              ),
              const SizedBox(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Warna garis batas
                    width: 2.0, // Ketebalan garis batas
                  ),
                ),
                child: uricAcid(),
              ),
              const SizedBox(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Warna garis batas
                    width: 2.0, // Ketebalan garis batas
                  ),
                ),
                child: cholesterol(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding cholesterol() {
    return Padding(
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
            _cholesterolresult,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Padding uricAcid() {
    return Padding(
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
              decoration: const InputDecoration(labelText: 'Berat Badan (kg)'),
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
              decoration: const InputDecoration(labelText: 'Tinggi Badan (cm)'),
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
                  Text('Asam Urat: ${_uricAcidResult!.toStringAsFixed(2)}'),
                  Text('Kondisi: $_condition'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Padding bloodSugar() {
    return Padding(
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
            _glucoseresult,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Padding bloodPressure() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          TextField(
            controller: _systolicController,
            decoration: const InputDecoration(
              labelText: 'Sistolik (mmHg)',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _diastolicController,
            decoration: const InputDecoration(
              labelText: 'Diastolik (mmHg)',
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
            _bloodpressureresult,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
