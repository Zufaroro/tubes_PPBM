import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Fungsi untuk mendapatkan role pengguna
  Future<String> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists && userDoc.data() != null && userDoc['role'] != null) {
          return userDoc['role'];
        } else {
          return 'human';
        }
      } catch (e) {
        print("Error fetching user role: $e");
        return 'human';
      }
    } else {
      return 'human';
    }
  }

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          String role = snapshot.data ?? 'human';
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: const Color(0xFFF7EDE5),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer(); // Membuka sidebar dengan ikon person
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Hello, ${role == 'doctor' ? 'Doctor' : 'Human'}!',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFFF7EDE5), // Warna latar belakang yang seragam
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person, size: 30, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(
                          'Hello, ${role == 'doctor' ? 'Doctor' : 'Human'}!',
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Manrope',
                            fontSize: 18, // Menyesuaikan ukuran font
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.fiber_new),
                    title: const Text("What's New"),
                    onTap: () {
                      print("What's New tapped");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("About"),
                    onTap: () {
                      print("About tapped");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Keluar"),
                    onTap: () {
                      signOut(context);
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Gambar
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: AssetImage('assets/image/Banner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search TextField
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Find best vaccinate, treatment...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Categories Title
                  Row(
                    children: [
                      const Text(
                        'C',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Image.asset(
                        'assets/image/paws.png',
                        height: 15,
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'tegories',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Horizontal Scrollable Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF6BD60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                          ),
                          child: const Text('Cats'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                          ),
                          child: const Text('Coming Soon'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cats',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Container untuk box di bawah Cats
                  Container(
                    width: double.infinity,
                    height: 150, // Sama dengan ukuran banner
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/image/kuro.png'),
                        opacity: 1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Kuro
                          Text(
                            'Kuro',
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Native Cat & Usia + Gender
                          Row(
                            children: [
                              const Text(
                                'Native Cat',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '• 1 Year 4 Months',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Ikon Gender (misalnya ikon wanita)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6BD60), // Background kuning
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.female, // Ganti dengan ikon sesuai keinginan
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Baris ketiga BMI dengan icon BMI
                          Row(
                            children: [
                              const Icon(
                                Icons.fitness_center, // Ikon BMI
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'BMI: 22.0', // Ganti dengan nilai BMI sesuai keinginan
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cats',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Container untuk box di bawah Cats
                  Container(
                    width: double.infinity,
                    height: 150, // Sama dengan ukuran banner
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/image/kuro.png'),
                        opacity: 1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Kuro
                          Text(
                            'Kuro',
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Native Cat & Usia + Gender
                          Row(
                            children: [
                              const Text(
                                'Native Cat',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '• 1 Year 4 Months',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Ikon Gender (misalnya ikon wanita)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6BD60), // Background kuning
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.female, // Ganti dengan ikon sesuai keinginan
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Baris ketiga BMI dengan icon BMI
                          Row(
                            children: [
                              const Icon(
                                Icons.fitness_center, // Ikon BMI
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'BMI: 22.0', // Ganti dengan nilai BMI sesuai keinginan
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
