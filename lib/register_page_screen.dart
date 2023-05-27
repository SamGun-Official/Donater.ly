import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/menu_page_screen.dart';

class RegisterPageScreen extends StatelessWidget {
  static const routeName = '/register_page_route';
  const RegisterPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LoginPage',
        theme: ThemeData(
          primaryColor: Colors.white, // Ganti dengan kode hex warna yang diinginkan
        ),
        home: RegisterPage(),
          routes: {
          '/menu_page_screen': (context) => MenuScreen(), // Definisikan rute untuk halaman kedua
        },
      );
    }
  }

class RegisterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}