// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextFieldWithShadow extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? initialValue;
  final bool enabled;

  const TextFieldWithShadow({
    Key? key,
    required this.label,
    required this.placeholder,
    this.enabled = true, // Default value is true
    this.initialValue, required TextEditingController controller,
  }) : super(key: key);

  @override
  _TextFieldWithShadowState createState() => _TextFieldWithShadowState();
}

class _TextFieldWithShadowState extends State<TextFieldWithShadow> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

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
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled, // Pass the enabled property
        decoration: InputDecoration(
          labelText: _isFocused ? widget.label : null,
          hintText: widget.placeholder,
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
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  void updateFirestoreData() {
  // Retrieve data from the text fields
  String name = _nameController.text;
  String email = _emailController.text;
  String phoneNumber = _phoneNumberController.text;

  // Update Firestore document
  _firestore.collection('Users').doc(currentUser.uid).update({
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
  }).then((value) {
    // Data successfully updated
    // Perform any desired actions here
  }).catchError((error) {
    // An error occurred while updating data
    // Handle the error appropriately
  });
}

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
              child: Container(
                child: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 120,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 3), // Increase width for a thicker border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
                const SizedBox(height: 16),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  stream: _firestore
                                      .collection('Users')
                                      .where("uid", isEqualTo: currentUser.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final userData = snapshot.data!.docs[0].data();
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          const SizedBox(height: 16),
                                          TextFieldWithShadow(
                                            label: 'Name',
                                            placeholder: 'Name',
                                            initialValue: '${userData['name']}',
                                            controller: _nameController
                                          ),
                                          const SizedBox(height: 16),
                                          TextFieldWithShadow(
                                            label: 'Email',
                                            placeholder: 'Email',
                                            initialValue: '${userData['email']}',
                                            controller: _emailController,
                                          ),
                                          const SizedBox(height: 16),
                                          TextFieldWithShadow(
                                            label: 'Phone Number',
                                            placeholder: 'Phone',
                                            initialValue: '${userData['phone']}',
                                            controller: _phoneNumberController,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your 'Continue' button logic here
                          //edit profile
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
                          Navigator.pop(context);
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
