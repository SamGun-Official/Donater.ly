import 'package:flutter/material.dart';

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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DonaterEditProfileScreen extends StatefulWidget {
  static const routeName = '/donater_edit_profile';

  const DonaterEditProfileScreen({super.key});
  @override
  State<DonaterEditProfileScreen> createState() =>
      _DonaterEditProfileScreenState();
}

class _DonaterEditProfileScreenState extends State<DonaterEditProfileScreen> {
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
                         InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                  backgroundImage: const AssetImage('images/profile.png'),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const TextFieldWithShadow(
                  label: 'Name',
                  placeholder: 'Cole Sprouse',
                ),
                const SizedBox(height: 16),
                const TextFieldWithShadow(
                  label: 'Username',
                  placeholder: 'coleesprouse',
                ),
                const SizedBox(height: 16),
                const TextFieldWithShadow(
                  label: 'Email',
                  placeholder: 'Cole_Sprouse@gmail.com',
                ),
                const SizedBox(height: 16),
                const TextFieldWithShadow(
                  label: 'Phone Number',
                  placeholder: '087855022221',
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your 'Continue' button logic here
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text('Continue'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your 'Cancel' button logic here
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text('Cancel'),
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
