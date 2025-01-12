// import 'package:flutter/material.dart';
// import 'screens/splash_screen.dart';
// import 'screens/login_page.dart';
// import 'screens/signup_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/login': (context) => const LoginPage(),
//         '/signup': (context) => const SignUpPage(),
//       },
//     );
//   }
// }

import 'package:cat_cat/firebase_options.dart';
import 'package:cat_cat/percobaan/auth/login_screen.dart';
import 'package:cat_cat/percobaan/check_out.dart';
import 'package:flutter/material.dart';
import 'package:cat_cat/percobaan/ikhwan_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import '../firebase_options.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  Future.delayed(const Duration(seconds: 2), () {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, statusBarColor: Colors.white));
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat dengan Dokter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 19,
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0),
                color: Colors.grey,
                blurRadius: 15.0,
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 246, 189, 96),
        ),
      ), // AppBar Theme // ThemeData
      home: const LoginScreen(),
    );
  }
}
