import 'dart:io';

import 'package:cat_cat/percobaan/api/apis.dart';
import 'package:cat_cat/percobaan/doctor_home_screen.dart';
import 'package:cat_cat/percobaan/helper/dialogs.dart';
import 'package:cat_cat/percobaan/ikhwan_home_screen.dart';
// ignore: unused_import
import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context); //buat munculin loading
    _signInWithGoogle().then((user) async {
      Navigator.pop(context); //buat ngilangin loading
      if (user != null) {
        log('\nuser: ${user.user}');
        log('\nuserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const DoctorHomeScreen()));
        } else if ((await APIs.userExists()) && APIs.me.isOnline == false) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const IkhwanHomeScreen()));
        } else {
          APIs.createUser().then((value) => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const IkhwanHomeScreen()))
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

  //sign out function
  // _signOut() async{
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome to Cat Cat'),
        backgroundColor: Color.fromARGB(463, 246, 189, 96),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF7EDE5),
        child: Stack(
          children: [
            Positioned(
                top: mq.height * .15,
                left: mq.width * .25,
                width: mq.width * .5,
                child: Image.asset('assets/image/icon_nobg.png')),
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
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                        TextSpan(text: 'Sign in with '),
                        TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ]))),
            ),
          ],
        ),
      ),
    );
  }
}
