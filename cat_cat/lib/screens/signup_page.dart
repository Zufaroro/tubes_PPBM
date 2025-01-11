import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isPasswordVisible = false; // Boolean untuk toggle password visibility

  // Fungsi untuk mendaftar pengguna
  Future<void> _signUp() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      final phone = _phoneController.text;

      // Mendaftar pengguna menggunakan Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mengambil UID pengguna yang baru dibuat
      String uid = userCredential.user!.uid;

      // Menyimpan informasi pengguna di Firestore dengan role default 'human'
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'phone': phone,
        'role': 'human', // Menetapkan role default sebagai 'human'
        'createdAt': Timestamp.now(),
      });

      // Navigasi langsung ke halaman login setelah sign up berhasil
      Navigator.pop(context); // Menutup halaman sign up
      Navigator.pop(context); // Kembali ke halaman login

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengubah background halaman menjadi putih
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/image/paws.jpg', height: 100),
                  const SizedBox(height: 20),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'NunitoSans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // Toggle visibility
                    decoration: InputDecoration(
                      labelText: 'Your Password',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Your Phone Number',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5),
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF6BD60),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'FredokaOne',
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman login
                    },
                    child: Column(
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: 'FredokaOne',
                          ),
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FredokaOne',
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
