import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_apps/ui/Home_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'images/splash_pic.jpg',
              height: dimension.height * .5,
              width: dimension.width * .9,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: dimension.height * 0.04,
          ),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.anton(
                letterSpacing: 0.6,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]),
          ),
          SizedBox(
            height: dimension.height * 0.04,
          ),
          const SpinKitChasingDots(
            color: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}
