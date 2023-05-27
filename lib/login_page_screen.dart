import 'package:flutter/material.dart';

class LoginPageScreen extends StatelessWidget {
  static const routeName = '/login_page_route';
  const LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginPage',
       theme: ThemeData(
         primaryColor: Colors.white, // Ganti dengan kode hex warna yang diinginkan
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}