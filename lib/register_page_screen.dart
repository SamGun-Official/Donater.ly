import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/menu_page_screen.dart';

class RegisterPageScreen extends StatefulWidget {
  static const routeName = '/register_page_route';
  const RegisterPageScreen({super.key});

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginPage',
      theme: ThemeData(
        primaryColor:
            Colors.white, // Ganti dengan kode hex warna yang diinginkan
      ),
      home: RegisterPage(),
      routes: {
        '/menu_page_screen': (context) =>
            const MenuScreen(), // Definisikan rute untuk halaman kedua
      },
    );
  }
}

class RegisterPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  RegisterPage({super.key});

  Future<bool> isUsernameUnique(String username) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  Future<bool> isPhoneUnique(String phone) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('phone', isEqualTo: phone)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double desiredHeightPercentage =
        0.05; // Adjust the desired height percentage (e.g., 0.5 for 50%)
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
                      'Create Account',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(107, 147, 225, 1),
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 28.0),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color.fromRGBO(
                              107, 147, 225, 1), // Change the icon color
                        ),
                        labelText: 'Username',
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.abc,
                          color: Color.fromRGBO(
                              107, 147, 225, 1), // Change the icon color
                        ),
                        labelText: 'Name',
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
                      obscureText: false,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.mail,
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
                      obscureText: false,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color.fromRGBO(107, 147, 225, 1),
                        ),
                        labelText: 'Phone Number',
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
                      obscureText: false,
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
                      width: 450,
                      height: 50,
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final name = _nameController.text;
                            final phone = _phoneController.text;
                            final username = _usernameController.text;

                            if (username.isEmpty ||
                                name.isEmpty ||
                                email.isEmpty ||
                                phone.isEmpty ||
                                password.isEmpty) {
                              throw Exception('All fields are required.');
                            }

                            // Check if the username is unique
                            final checkUsernameUnique =
                                await isUsernameUnique(username);
                            if (!checkUsernameUnique) {
                              throw Exception('Username is already taken.');
                            }

                            // Check if the phone number is unique
                            final checkPhoneUnique = await isPhoneUnique(phone);
                            if (!checkPhoneUnique) {
                              throw Exception(
                                  'Phone number is already registered.');
                            }

                            // Regular expression to match a valid phone number format
                            final phoneRegex = RegExp(r'^08[0-9]{8,10}$');

                            // Check if the phone number is in the correct format
                            if (!phoneRegex.hasMatch(phone)) {
                              throw Exception(
                                  'Invalid phone number format. Please enter a 10 to 12-digit phone number starting with "08".');
                            }

                            // Validate password
                            if (password.length < 8) {
                              throw Exception(
                                  'Password must be at least 8 characters long.');
                            }
                            if (!password.contains(RegExp(r'[A-Z]'))) {
                              throw Exception(
                                  'Password must contain at least one uppercase letter.');
                            }
                            if (!password.contains(RegExp(r'[a-z]'))) {
                              throw Exception(
                                  'Password must contain at least one lowercase letter.');
                            }
                            if (!password.contains(RegExp(r'[0-9]'))) {
                              throw Exception(
                                  'Password must contain at least one digit.');
                            }

                            await _auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) async {
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .add({
                                'username': username,
                                'password': password,
                                'email': email,
                                'name': name,
                                'phone': phone,
                                'uid': value.user!.uid
                              });
                            }).then((value) {
                              const snackbar =
                                  SnackBar(content: Text("Account created!"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
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
                        child: const Text('Create Account'),
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
