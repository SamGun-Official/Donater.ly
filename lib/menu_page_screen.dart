import 'package:flutter/material.dart';
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
      home: const LoginRegisterPage(),
      routes: {
        '/login_page_screen': (context) =>
            const LoginPageScreen(), // Definisikan rute untuk halaman kedua
        '/register_page_route': (context) => const RegisterPageScreen()
      },
    );
  }
}

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(107, 147, 225, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Set your desired border radius here
                      ),
                    ),
                  ),
                  child: const Text('Sign In'),
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(107, 147, 225, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Set your desired border radius here
                      ),
                    ),
                  ),
                  child: const Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
