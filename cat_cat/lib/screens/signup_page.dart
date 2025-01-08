import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Membungkus dengan SingleChildScrollView untuk menggulir
          child: Center( // Konten akan diposisikan di tengah
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Menjaga agar konten di tengah secara vertikal
                crossAxisAlignment: CrossAxisAlignment.center, // Menjaga agar konten di tengah secara horizontal
                children: [
                  // Logo
                  Image.asset('assets/image/paws.jpg', height: 100),
                  const SizedBox(height: 20),
                  // Headline
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 30, 
                      fontWeight: FontWeight.w800,
                      fontFamily: 'NunitoSans', // Gunakan font keluarga langsung
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Input
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5), // Light color background
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // Lebih rounded
                        borderSide: BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Password Input
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Your Password',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5), // Light color background
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // Lebih rounded
                        borderSide: BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Phone Number Input
                  TextField(
                    keyboardType: TextInputType.phone, // Membatasi input hanya angka
                    decoration: InputDecoration(
                      labelText: 'Your Phone Number',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5), // Light color background
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // Lebih rounded
                        borderSide: BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity, // Membuat tombol sebesar input
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle sign up action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF6BD60), // Warna latar belakang tombol
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(
                        fontSize: 18, 
                        color: Colors.black, 
                        fontFamily: 'FredokaOne', 
                        fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded button
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Login Link
                  TextButton(
                    onPressed: () {
                      // Navigate back to login page
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5), // Teks transparan
                            fontFamily: 'FredokaOne', // Gunakan font keluarga langsung
                          ),
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.black, // Teks dengan opacity penuh
                            fontWeight: FontWeight.bold, // Teks tebal
                            fontFamily: 'FredokaOne', // Gunakan font keluarga langsung
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
      ),
    );
  }
}
