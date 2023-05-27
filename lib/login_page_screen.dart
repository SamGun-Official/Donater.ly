import 'package:flutter/material.dart';

class LoginPageScreen extends StatelessWidget {
    static const routeName = '/login_page_screen';
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

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_white.jpg'), // Ganti dengan path/lokasi gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child:       Padding(
        padding: EdgeInsets.all(16.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Color.fromRGBO(107,147,225,1), // Change the border color
            hintColor: Colors.blueGrey, // Change the hint text color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
              'Sign In',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(107,147,225,1),
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 28.0),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromRGBO(107,147,225,1), // Change the icon color
                  ),
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(107,147,225,1), // Change the border color
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(107,147,225,1), // Change the border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(107,147,225,1), // Change the border color
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 10.0,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(107,147,225,1), // Change the icon color
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(107,147,225,1), // Change the border color
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(107,147,225,1), // Change the border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(107,147,225,1), // Change the border color
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 10.0,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
             Container(
              width: 350,
              height: 50,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // Tombol register ditekan
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
            ],
          ),
        ),
      ),
      ),    
    );
  }
}