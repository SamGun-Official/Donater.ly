import 'package:flutter/material.dart';
import 'package:donaterly_app/donater_screen/home_screen.dart';
import 'package:donaterly_app/donater_screen/detail_screen.dart';
import 'package:donaterly_app/donater_screen/donate_screen.dart';
import 'package:donaterly_app/main_donater.dart';
import 'package:donaterly_app/menu_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPageScreen extends StatefulWidget {
  static const routeName = '/login_page_screen';
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginPage',
      theme: ThemeData(
        primaryColor:
            Colors.white, // Ganti dengan kode hex warna yang diinginkan
      ),
      home: LoginPage(),
      routes: {
        '/menu_page_screen': (context) =>
            const MenuScreen(), // Definisikan rute untuk halaman kedua
        '/donater_home_route': (context) => const DonaterHomeScreen(),
        '/donater_detail_route': (context) => const DonaterDetailScreen(),
        '/donater_donate_route': (context) => const DonaterDonateScreen(),
        MainDonater.routeName: (context) => const MainDonater(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double desiredHeightPercentage =
        0.1; // Adjust the desired height percentage (e.g., 0.5 for 50%)
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/background_white.jpg'), // Ganti dengan path/lokasi gambar Anda
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: const Color.fromRGBO(
                      107, 147, 225, 1), // Change the border color
                  hintColor: Colors.blueGrey, // Change the hint text color
                ),
                child: ListView(
                  children: [
                    SizedBox(
                        height: screenHeight *
                            0.02), // Added extra space to align the back button properly
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MenuScreen.routeName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
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
                        color: Color.fromRGBO(107, 147, 225, 1),
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
                    const SizedBox(height: 28.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color.fromRGBO(
                              107, 147, 225, 1), // Change the icon color
                        ),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                107, 147, 225, 1), // Change the border color
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                107, 147, 225, 1), // Change the border color
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                107, 147, 225, 1), // Change the border color
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
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color.fromRGBO(
                              107, 147, 225, 1), // Change the icon color
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                107, 147, 225, 1), // Change the border color
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                107, 147, 225, 1), // Change the border color
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(
                                107, 147, 225, 1), // Change the border color
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
                        onPressed: () async {
                          try {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            await _auth
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) {
                              Navigator.pushNamed(context, '/main_donater');
                            });
                          } on Exception catch (e) {
                            final snackbar =
                                SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } finally {}
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(107, 147, 225, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15), // Set your desired border radius here
                            ),
                          ),
                        ),
                        child: const Text('Sign In'),
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
