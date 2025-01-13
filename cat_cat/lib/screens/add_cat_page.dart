import 'package:flutter/material.dart';
import 'package:cat_cat/screens/cat_model.dart';

class AddCatPage extends StatefulWidget {
  @override
  _AddCatPageState createState() => _AddCatPageState();
}

class _AddCatPageState extends State<AddCatPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  void _saveCat() {
    final String name = _nameController.text;
    final String age = _ageController.text;
    final String bmi = _bmiController.text;

    if (name.isNotEmpty && age.isNotEmpty && bmi.isNotEmpty) {
      final newCat = Cat(
        name: name,
        age: age,
        bmi: bmi,
        image: 'assets/cat_placeholder.png', // Gambar placeholder
      );
      Navigator.pop(context, newCat);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Kucing'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Kucing',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Umur Kucing (contoh: 1 Tahun 4 Bulan)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _bmiController,
              decoration: InputDecoration(
                labelText: 'BMI (contoh: NORMAL)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveCat,
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
