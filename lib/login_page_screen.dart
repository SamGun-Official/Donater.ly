import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/menu_page_screen.dart';

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
        routes: {
        '/menu_page_screen': (context) => MenuScreen(), // Definisikan rute untuk halaman kedua
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double desiredHeightPercentage = 0.15; // Adjust the desired height percentage (e.g., 0.5 for 50%)
    return Scaffold(
      body: 
      Stack(
        children: [
          Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_white.jpg'), // Ganti dengan path/lokasi gambar Anda
              fit: BoxFit.cover,
            ),
        ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color.fromRGBO(107,147,225,1), // Change the border color
                hintColor: Colors.blueGrey, // Change the hint text color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight*0.08), // Added extra space to align the back button properly 
               Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color.fromRGBO(107, 147, 225, 1),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/menu_page_screen');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * desiredHeightPercentage,
                ),
                const Text(
                'Sign In',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(107,147,225,1),
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Please Sign in To Continue',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 28.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color.fromRGBO(107,147,225,1), // Change the icon color
                    ),
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(107,147,225,1), // Change the border color
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(107,147,225,1), // Change the border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(107,147,225,1), // Change the border color
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 10.0,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color.fromRGBO(107,147,225,1), // Change the icon color
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(107,147,225,1), // Change the border color
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(107,147,225,1), // Change the border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(107,147,225,1), // Change the border color
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 10.0,
                    ),
                  ),
                  obscureText: true,
                ),
              const SizedBox(height: 16.0),
              Container(
                width: 350,
                height: 50,
                margin: const EdgeInsets.all(10),
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
            )
          ],
        ),    
    );
  }
}