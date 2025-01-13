import 'dart:developer';
import 'dart:io';

import 'package:cat_cat/main.dart';
import 'package:cat_cat/percobaan/api/apis.dart';
import 'package:cat_cat/percobaan/doctor_home_screen.dart';
import 'package:cat_cat/percobaan/helper/dialogs.dart';
import 'package:cat_cat/percobaan/ikhwan_home_screen.dart';
import 'package:cat_cat/screens/Homepage_human.dart';
import 'package:cat_cat/screens/login_page.dart';
import 'package:cat_cat/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final time = DateTime.now().millisecondsSinceEpoch.toString();

      // Mengambil UID pengguna yang baru dibuat
      String uid = userCredential.user!.uid;

      // Menyimpan informasi pengguna di Firestore dengan role default 'human'
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        // 'email': email,
        // 'phone': phone,
        // 'role': 'human', // Menetapkan role default sebagai 'human'
        // 'createdAt': Timestamp.now(),
        'image': "https://www.flaticon.com/free-icons/person",
        'name': email.split('@')[0],
        'about': 4,
        'created_at': time,
        'is_online': false,
        'id': uid,
        'last_active': time,
        'email': email.toString(),
        'push_token': '',
        'role': 'human',
      });

      // Navigasi langsung ke halaman login setelah sign up berhasil
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => LoginPage())); // Menutup halaman sign up
      // Navigator.pop(context); // Kembali ke halaman login
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
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
              context, MaterialPageRoute(builder: (_) => const MainScreen()));
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
    return Scaffold(
      backgroundColor:
          Colors.white, // Mengubah background halaman menjadi putih
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
                  Image.asset('assets/image/paws.jpg', height: 100),
                  const SizedBox(height: 20),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily:
                          'NunitoSans', // Gunakan font keluarga langsung
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(
                        color: Colors.black
                            .withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Lebih rounded
                        borderSide:
                            BorderSide.none, // Menghilangkan stroke hitam
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
                        color: Colors.black
                            .withOpacity(0.7), // Teks label lebih transparan
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
                            _isPasswordVisible =
                                !_isPasswordVisible; // Toggle visibility
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
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType:
                        TextInputType.phone, // Membatasi input hanya angka
                    decoration: InputDecoration(
                      labelText: 'Your Phone Number',
                      labelStyle: TextStyle(
                        color: Colors.black
                            .withOpacity(0.7), // Teks label lebih transparan
                        fontFamily: 'FredokaOne',
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7EDE5),
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Lebih rounded
                        borderSide:
                            BorderSide.none, // Menghilangkan stroke hitam
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFF6BD60), // Warna latar belakang tombol
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
                            color: Colors.black
                                .withOpacity(0.5), // Teks transparan
                            fontFamily:
                                'FredokaOne', // Gunakan font keluarga langsung
                          ),
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.black, // Teks dengan opacity penuh
                            fontWeight: FontWeight.bold, // Teks tebal
                            fontFamily:
                                'FredokaOne', // Gunakan font keluarga langsung
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
