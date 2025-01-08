import 'package:flutter/material.dart';
import 'package:cat_cat/screens/cat_detail_screen.dart';

class ProgressScreen extends StatelessWidget {
  final List<Map<String, String>> cats = [
    {
      "name": "Kuro",
      "age": "1 Tahun 4 bulan",
      "bmi": "NORMAL",
      "image": "https://placekitten.com/100/100",
      "details": "Kuro is an energetic black cat who loves to play and nap in the sun.",
      "gender": "male",
    },
    {
      "name": "Mimi",
      "age": "2 Tahun 1 bulan",
      "bmi": "NORMAL",
      "image": "https://placekitten.com/101/101",
      "details": "Mimi is a gentle white cat who enjoys quiet moments and cuddles.",
      "gender": "female",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF0E9),
      appBar: AppBar(
        title: Text(
          "Your cat progress",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, index) {
          final cat = cats[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatDetailScreen(cat: cat),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(cat["image"]!),
                      radius: 40,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                cat["gender"] == "male" ? 'assets/image/male-gender.png' : 'assets/image/cewe.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                cat["name"]!,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(cat["age"]!, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 4),
                          Text(
                            "BMI: ${cat["bmi"]!}",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new cat
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
