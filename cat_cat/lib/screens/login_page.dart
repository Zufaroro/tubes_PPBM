import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage_human.dart'; // Ganti dengan halaman yang sesuai

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // Menyimpan status visibility password

  // Fungsi untuk login pengguna
  Future<void> _login() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Melakukan login menggunakan Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jika login berhasil, arahkan ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Tangani error jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengubah background menjadi putih
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
                    'Log In to CatCat',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 30, 
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Input
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7EDE5), // Light color background
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // Lebih rounded
                        borderSide: BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Password Input
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText, // Menentukan apakah password tersembunyi atau tidak
                    decoration: InputDecoration(
                      labelText: 'Your Password',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7EDE5), // Light color background
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility, // Ikon untuk show/hide password
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText; // Toggle visibility password
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // Lebih rounded
                        borderSide: BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity, // Membuat tombol sebesar input
                    child: ElevatedButton(
                      onPressed: _login, // Panggil fungsi login
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF6BD60), // Warna latar belakang tombol
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 18, 
                          color: Colors.black, 
                          fontFamily: 'FredokaOne', 
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded button
                        ),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Sign Up Link
                  TextButton(
                    onPressed: () {
                      // Navigasi ke halaman sign up
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Column(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5), // Teks transparan
                            fontFamily: 'FredokaOne', 
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black, // Teks dengan opacity penuh
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
