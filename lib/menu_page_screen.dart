import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu_page_screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Register Page',
      theme: ThemeData(
         primaryColor: Colors.white, // Ganti dengan kode hex warna yang diinginkan
        
      ),
      home: LoginRegisterPage(),
    );
  }
}

class LoginRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_white.jpg'), // Ganti dengan path/lokasi gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Image.asset('images/logo.png')
            ),
            Container(
              width: 350,
              height: 50,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // Tombol login ditekan
                },
                child: Text('Sign In'),
                  style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(107,147,225,1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Set your desired border radius here
                  ),
                ),
                ),
              ),
            ),
            Container(
              width: 350,
              height: 50,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // Tombol register ditekan
                },
                child: Text('Create Account'),
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(107,147,225,1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Set your desired border radius here
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

