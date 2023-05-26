import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu_page_screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Register Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginRegisterPage(),
    );
  }
}

class LoginRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
     body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Image.asset('images/logo.jpg')
            ),
            Container(
              width: 350,
              height: 50,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // Tombol login ditekan
                },
                child: Text('Login'),
                  style: ButtonStyle(
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
                child: Text('Register'),
                style: ButtonStyle(
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
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Text('Register Page'),
      ),
    );
  }
}