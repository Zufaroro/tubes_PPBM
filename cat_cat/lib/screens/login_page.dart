import 'dart:developer';
import 'dart:io';

import 'package:cat_cat/main.dart';
import 'package:cat_cat/percobaan/doctor_home_screen.dart';
import 'package:cat_cat/screens/main_screen.dart';
import 'package:cat_cat/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/homepage_human.dart'; // Ganti dengan halaman yang sesuai
import 'package:cat_cat/percobaan/helper/dialogs.dart';
import 'package:cat_cat/percobaan/api/apis.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jika login berhasil, arahkan ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      // Tangani error jika login gagal
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context); //buat munculin loading
    _signInWithGoogle().then((user) async {
      Navigator.pop(context); //buat ngilangin loading
      if (user != null) {
        log('\nuser: ${user.user}');
        log('\nuserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MainScreen()));
        } else {
          APIs.createUser().then((value) => {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainScreen()))
              });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackBar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, // Mengubah background menjadi putih
      body: SafeArea(
        child: SingleChildScrollView(
          // Membungkus dengan SingleChildScrollView untuk menggulir
          child: Center(
            // Konten akan diposisikan di tengah
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Menjaga agar konten di tengah secara vertikal
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Menjaga agar konten di tengah secara horizontal
                children: [
                  // Logo
                  Image.asset('assets/image/paws.jpg', height: 100),
                  const SizedBox(height: 20),
                  // Headline
                  Text(
                    'Log In to CatCat',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily:
                          'NunitoSans', // Font family yang konsisten dengan halaman sign up
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Input
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                        color: Colors.black
                            .withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor:
                          const Color(0xFFF7EDE5), // Light color background
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Lebih rounded
                        borderSide:
                            BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Password Input
                  TextField(
                    controller: _passwordController,
                    obscureText:
                        _obscureText, // Menentukan apakah password tersembunyi atau tidak
                    decoration: InputDecoration(
                      labelText: 'Your Password',
                      labelStyle: TextStyle(
                        color: Colors.black
                            .withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold, // Teks label lebih tebal
                      ),
                      filled: true,
                      fillColor:
                          const Color(0xFFF7EDE5), // Light color background
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons
                                  .visibility, // Ikon untuk show/hide password
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText =
                                !_obscureText; // Toggle visibility password
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Lebih rounded
                        borderSide:
                            BorderSide.none, // Menghilangkan stroke hitam
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
                        backgroundColor: const Color(
                            0xFFF6BD60), // Warna latar belakang tombol
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'FredokaOne',
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded button
                        ),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                  SizedBox(height: mq.height * .10),
                  // Sign Up Link
                  TextButton(
                    onPressed: () {
                      // Navigasi ke halaman sign up
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpPage()));
                    },
                    child: Column(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black
                                .withOpacity(0.5), // Teks transparan
                            fontFamily:
                                'NunitoSans', // Gunakan font keluarga langsung
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black, // Teks dengan opacity penuh
                            fontWeight: FontWeight.bold, // Teks tebal
                            fontFamily:
                                'NunitoSans', // Gunakan font keluarga langsung
                          ),
                        ),
                        const Divider(height: 32),
                        Positioned(
                          bottom: mq.height * .15,
                          left: mq.width * .05,
                          width: mq.width * .9,
                          height: mq.height * .06,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                elevation: 1,
                              ),
                              onPressed: () {
                                _handleGoogleBtnClick();
                              },
                              icon: Image.asset(
                                'assets/image/google.png',
                                height: mq.height * .03,
                              ),
                              label: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      children: [
                                    TextSpan(text: 'Sign in with '),
                                    TextSpan(
                                        text: 'Google',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ]))),
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
