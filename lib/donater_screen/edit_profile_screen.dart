import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/bottom_navigation.dart';

class TextFieldWithShadow extends StatelessWidget {
  final String label;
  final String placeholder;

  const TextFieldWithShadow({
    Key? key,
    required this.label,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DonaterEditProfileScreen extends StatefulWidget {
  static const routeName = '/donater_edit_profile';
  @override
  State<DonaterEditProfileScreen> createState() =>
      _DonaterEditProfileScreenState();
}

class _DonaterEditProfileScreenState extends State<DonaterEditProfileScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Opacity(
                            opacity: 0.0,
                            child: Icon(
                              Icons.bookmark_outline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/cole_second.jpg'),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  label: 'Name',
                  placeholder: 'Cole Sprouse',
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  label: 'Username',
                  placeholder: 'coleesprouse',
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  label: 'Email',
                  placeholder: 'Cole_Sprouse@gmail.com',
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  label: 'Phone Number',
                  placeholder: '087855022221',
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your 'Continue' button logic here
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        child: Text('Continue'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your 'Cancel' button logic here
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                        child: Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}
