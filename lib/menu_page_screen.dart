import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/donater_screen/detail_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/home_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/donate_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/profile_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/transaction_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/saved_donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/edit_profile_screen.dart';
import 'package:multiplatform_donation_app/login_page_screen.dart';
import 'package:multiplatform_donation_app/register_page_screen.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu_page_screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Register Page',
      theme: ThemeData(
        primaryColor:
            Colors.white, // Ganti dengan kode hex warna yang diinginkan
      ),
      home: DonaterDonationScreen(),
      routes: {
        '/login_page_screen': (context) =>
            LoginPageScreen(), // Definisikan rute untuk halaman kedua
        '/register_page_route': (context) => RegisterPageScreen()
      },
    );
  }
}

class LoginRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/background_white.jpg'), // Ganti dengan path/lokasi gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(20),
                  child: Image.asset('images/logo.png')),
              Container(
                width: 350,
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    // Tombol login ditekan
                    Navigator.pushNamed(context,
                        '/login_page_screen'); // Pindahkan ke halaman login
                  },
                  child: Text('Sign In'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(107, 147, 225, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Set your desired border radius here
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    // Tombol register ditekan
                    Navigator.pushNamed(context,
                        '/register_page_route'); // Pindahkan ke halaman register
                  },
                  child: Text('Create Account'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(107, 147, 225, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Set your desired border radius here
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
