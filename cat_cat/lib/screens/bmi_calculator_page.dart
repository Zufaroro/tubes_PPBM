import 'package:flutter/material.dart';

class FBMICalculator extends StatefulWidget {
  @override
  _FBMICalculatorState createState() => _FBMICalculatorState();
}

class _FBMICalculatorState extends State<FBMICalculator> {
  final TextEditingController _ribCageController = TextEditingController();
  final TextEditingController _legLengthController = TextEditingController();

  String _result = "";

  void calculateFBMI() {
    // Ambil nilai input dan konversi ke angka
    final double? ribCage = double.tryParse(_ribCageController.text);
    final double? legLength = double.tryParse(_legLengthController.text);

    // Validasi input
    if (ribCage == null || ribCage <= 0 || legLength == null || legLength <= 0) {
      setState(() {
        _result = "⚠️ Please enter valid numbers for both fields!";
      });
      return;
    }

    // Hitung FBMI dengan rumus baru
    double step1 = ribCage / 0.7062;
    double step2 = step1 - legLength;
    double step3 = step2 / 0.9156;
    double fbmi = step3 - legLength;

    // Tentukan interpretasi
    String interpretation;
    if (fbmi < 15) {
      interpretation = "Underweight 🐾";
    } else if (fbmi >= 15 && fbmi < 30) {
      interpretation = "Normal weight ✅";
    } else if (fbmi >= 30 && fbmi <= 42) {
      interpretation = "Overweight ⚠️";
    } else {
      interpretation = "Obese ❌";
    }

    // Tampilkan hasil
    setState(() {
      _result = "FBMI: ${fbmi.toStringAsFixed(2)}\nStatus: $interpretation";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat FBMI Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _ribCageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Lingkar Tulang Rusuk (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _legLengthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Panjang Kaki Bagian Belakang (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateFBMI,
              child: Text("Calculate FBMI"),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}