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

import 'package:flutter/material.dart';
import 'percobaan/note_list.dart';
import 'screens/TutorialScreen.dart';
import 'screens/addvid.dart';
import 'screens/progress_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home:ProgressScreen()
    );
  }
}
