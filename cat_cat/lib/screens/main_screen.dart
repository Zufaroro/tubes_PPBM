import 'dart:ffi';
import 'package:cat_cat/percobaan/doctor_home_screen.dart';
import 'package:cat_cat/percobaan/ikhwan_home_screen.dart';
import 'package:cat_cat/screens/Homepage_human.dart';
import 'package:cat_cat/screens/bmi_calculator_page.dart';
import 'package:cat_cat/screens/cat_list_page.dart';
import 'package:cat_cat/screens/progres_page.dart';
import 'package:cat_cat/screens/tutorial_page.dart';
import 'package:cat_cat/screens/video_list_page.dart';
import 'package:cat_cat/screens/video_tutorial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _role = '';
  int _selectedIndex = 0;

  // Fetch user role from Firebase
  Future<void> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();
        if (userDoc.exists && userDoc['role'] != null) {
          setState(() {
            _role = userDoc['role'];
          });
        }
      } catch (e) {
        print("Error fetching user role: $e");
      }
    } else {
      setState(() {
        _role = 'human'; // Default role
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  // Build pages dynamically based on role
  List<Widget> getPages() {
    return [
      const HomePage(),
      if (_role == 'human') const VideoTutorialPage(),
      if (_role == 'doctor') const VideoListPage(),
      if (_role == 'human') FBMICalculator(),
      if (_role == 'human') CatListPage(),
      if (_role == 'doctor') const DoctorHomeScreen(),
    ];
  }

  // Build BottomNavigationBar items dynamically based on role
  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.black),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.school, color: Colors.black),
        label: 'Tutorial',
      ),
      if (_role == 'human')
        const BottomNavigationBarItem(
          icon: Icon(Icons.calculate_outlined, color: Colors.black),
          label: 'Kalkulator',
        ),
      if (_role == 'doctor')
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Colors.black),
          label: 'Chat',
        )
      else
        const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, color: Colors.black),
          label: 'Progress',
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_role.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final pages = getPages();

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFF6BD60),
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: getBottomNavigationBarItems(),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}
