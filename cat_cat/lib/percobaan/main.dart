// import 'package:cat_cat/percobaan/note_detail.dart';
import 'package:cat_cat/percobaan/ikhwan_home_screen.dart';
import 'package:flutter/material.dart';

//global object for accessing device screen size
late Size mq;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat dengan Dokter',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 19,
            shadows: [
              Shadow(
                color: Colors.black,
              ),
            ],
          ),
          backgroundColor: Colors.amber,
        )), // AppBar Theme // ThemeData
        home: const IkhwanHomeScreen());
  }
}
