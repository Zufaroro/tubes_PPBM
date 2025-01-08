import 'package:flutter/material.dart';
import 'dart:ui';

class CatDetailScreen extends StatelessWidget {
  final Map<String, String> cat;

  CatDetailScreen({required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF0E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          cat['name']!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(cat['image']!),
                  radius: 50,
                ),
              ),
              SizedBox(height: 16),
              Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.2), // Transparent white for glass effect
    borderRadius: BorderRadius.circular(12), // Rounded corners
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), // Subtle shadow
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Stack(
    children: [
      // Glass effect using BackdropFilter
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kuro', // Replace with `cat['name']`
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4), // Spacing
                Text(
                  'Kucing Kampungan · 1/Thn 4/bln', // Replace with `cat['details']`
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8), // Space between text and icon
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber, // Yellow background for the icon
              shape: BoxShape.circle, // Circular icon
            ),
            child: Image.asset(
              cat['gender'] == 'male'
                  ? 'assets/image/male-gender.png'
                  : 'assets/image/cewe.png',
              height: 24, // Adjust icon size
              width: 24,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ],
  ),
),
            
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("about kuro"),
                       SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                       
                        
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Lingkar Tulang Rusuk", style: TextStyle(fontSize: 14, color: Colors.grey)),
                            SizedBox(height: 4),
                            Text("30 cm", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text("Panjang Kaki Belakang", style: TextStyle(fontSize: 14, color: Colors.grey)),
                            SizedBox(height: 4),
                            Text("10 cm", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Medical Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _buildMedicalTag("Telah Divaksin", Colors.green),
                  SizedBox(width: 8),
                  _buildMedicalTag("Steril", Colors.orange),
                  SizedBox(width: 8),
                  _buildMedicalTag("Ekor Buntung", Colors.red),
                ],
              ),
              SizedBox(height: 20),
              Text(
                cat['details']!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalTag(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
