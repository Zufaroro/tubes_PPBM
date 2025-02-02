import 'package:cat_cat/screens/login_page.dart';
import 'package:cat_cat/screens/main_screen.dart';
import 'package:cat_cat/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/SplashScreen.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            if (FirebaseAuth.instance.currentUser != null) {
              // Navigate to HomePage after the video finishes
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            } else {
              // Navigate to LoginPage after the video finishes
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SignUpPage()));
            }
          }
        });
      });
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (_controller.value.isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          if (!_controller.value.isInitialized)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
