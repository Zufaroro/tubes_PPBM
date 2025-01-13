import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_cat_page.dart';
import 'package:cat_cat/screens/cat_model.dart';

class CatListPage extends StatefulWidget {
  @override
  _CatListPageState createState() => _CatListPageState();
}

class _CatListPageState extends State<CatListPage> {
  List<Cat> _cats = [];

  @override
  void initState() {
    super.initState();
    _loadCats();
  }

  // Fungsi untuk memuat data dari SharedPreferences
  Future<void> _loadCats() async {
    final prefs = await SharedPreferences.getInstance();
    final String? catsJson = prefs.getString('cats');
    if (catsJson != null) {
      final List<dynamic> decoded = jsonDecode(catsJson);
      setState(() {
        _cats = decoded.map((cat) => Cat.fromMap(cat)).toList();
      });
    }
  }

  // Fungsi untuk menyimpan data ke SharedPreferences
  Future<void> _saveCats() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, String>> mappedCats =
        _cats.map((cat) => cat.toMap()).toList();
    await prefs.setString('cats', jsonEncode(mappedCats));
  }

  // Fungsi untuk menambahkan kucing baru
  void _addCat(Cat cat) {
    setState(() {
      _cats.add(cat);
    });
    _saveCats(); // Simpan ke SharedPreferences setelah menambah data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cat Progress'),
        backgroundColor: Colors.orange,
      ),
      body: _cats.isEmpty
          ? Center(
              child: Text(
                'Belum ada data kucing.\nTambahkan data dengan menekan tombol +',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _cats.length,
              itemBuilder: (context, index) {
                final cat = _cats[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(cat.image),
                    ),
                    title: Text(cat.name),
                    subtitle: Text('${cat.age}\nBMI: ${cat.bmi}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCatPage()),
          );

          if (result != null && result is Cat) {
            _addCat(result);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
