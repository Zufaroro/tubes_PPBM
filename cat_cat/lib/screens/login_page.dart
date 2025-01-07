// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView( // Membungkus dengan SingleChildScrollView untuk menggulir
//           child: Center( // Konten akan diposisikan di tengah
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center, // Menjaga agar konten di tengah secara vertikal
//                 crossAxisAlignment: CrossAxisAlignment.center, // Menjaga agar konten di tengah secara horizontal
//                 children: [
//                   // Logo
//                   Image.asset('assets/image/paws.jpg', height: 100),
//                   const SizedBox(height: 20),
//                   // Headline
//                   Text(
//                     'Log In to CatCat',
//                     style: TextStyle(
//                       fontSize: 30, 
//                       fontWeight: FontWeight.w800,
//                       fontFamily: 'NunitoSans', // Font family yang konsisten dengan halaman sign up
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Email Input
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Your Email',
//                       labelStyle: TextStyle(
//                         color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
//                         fontFamily: 'FredokaOne',
//                         fontWeight: FontWeight.bold, // Teks label lebih tebal
//                       ),
//                       filled: true,
//                       fillColor: const Color(0xFFF7EDE5), // Light color background
//                       prefixIcon: const Icon(Icons.email),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30), // Lebih rounded
//                         borderSide: BorderSide.none, // Menghilangkan stroke hitam
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Password Input
//                   TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Your Password',
//                       labelStyle: TextStyle(
//                         color: Colors.black.withOpacity(0.7), // Teks label lebih transparan
//                         fontFamily: 'FredokaOne',
//                         fontWeight: FontWeight.bold, // Teks label lebih tebal
//                       ),
//                       filled: true,
//                       fillColor: const Color(0xFFF7EDE5), // Light color background
//                       prefixIcon: const Icon(Icons.lock),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30), // Lebih rounded
//                         borderSide: BorderSide.none, // Menghilangkan stroke hitam
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Log In Button
//                   SizedBox(
//                     width: double.infinity, // Membuat tombol sebesar input
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Handle login action
//                       },
//                       child: const Text('Log In'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF6BD60), // Warna latar belakang tombol
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         textStyle: TextStyle(
//                         fontSize: 18, 
//                         color: Colors.black, 
//                         fontFamily: 'FredokaOne', 
//                         fontWeight: FontWeight.bold,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30), // Rounded button
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Sign Up Link
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to sign up page
//                       Navigator.pushNamed(context, '/signup');
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           "Don't Have An Account?",
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(0.5), // Teks transparan
//                             fontFamily: 'NunitoSans', // Gunakan font keluarga langsung
//                           ),
//                         ),
//                         Text(
//                           "Sign Up",
//                           style: TextStyle(
//                             color: Colors.black, // Teks dengan opacity penuh
//                             fontWeight: FontWeight.bold, // Teks tebal
//                             fontFamily: 'NunitoSans', // Gunakan font keluarga langsung
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
