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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          "Your cat progress",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0), // Horizontal and vertical offset
                blurRadius: 3.0, // Blur radius
                color: Colors.grey.withOpacity(0.5), // Shadow color
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false, // Align title to the left
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, index) {
          final cat = cats[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatDetailScreen(cat: cat),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(cat["image"]!),
                        radius: 60,
                      ),
                      SizedBox(width: 32),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  cat["gender"] == "male"
                                      ? 'assets/image/male-gender.png'
                                      : 'assets/image/cewe.png',
                                  height: 28,
                                  width: 28,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  cat["name"]!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              cat["age"]!,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "BMI: ${cat["bmi"]!}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
