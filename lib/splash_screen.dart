import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen_route';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    // Timer untuk mengatur waktu tampilan SplashScreen
    Timer(Duration(seconds: 3), () {
      // Navigasi ke halaman berikutnya setelah 3 detik
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Desain tampilan SplashScreen
      body: AnimatedOpacity(
        opacity: _opacityLevel,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOut,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin: EdgeInsets.all(20.0), child: Image.asset('images/logo.jpg')),
              SizedBox(height: 24),
              // CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}