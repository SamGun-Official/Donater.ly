// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextFieldWithShadow extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? initialValue;
  final bool enabled;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const TextFieldWithShadow({
    Key? key,
    required this.label,
    required this.placeholder,
    this.enabled = true,
    this.initialValue,
    required this.controller,
    this.onChanged,
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
        controller: widget.controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: _isFocused ? widget.label : null,
          hintText: widget.placeholder,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DonaterEditProfileScreen extends StatefulWidget {
  static const routeName = '/donater_edit_profile';

  const DonaterEditProfileScreen({Key? key}) : super(key: key);

  @override
  _DonaterEditProfileScreenState createState() =>
      _DonaterEditProfileScreenState();
}

class _DonaterEditProfileScreenState extends State<DonaterEditProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final snapshot = await _firestore
          .collection('Users')
          .where('uid', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs[0].data();
        _nameController.text = userData['name'];
        _emailController.text = userData['email'];
        _phoneNumberController.text = userData['phone'];
        _usernameController.text = userData['username'];
      }
    } catch (error) {
      // Handle error
    }
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
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
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
                      color: Colors.blue,
                      size: 120,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.blue,
                          width: 3), // Increase width for a thicker border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'Username',
                      placeholder: 'Username',
                      controller: _usernameController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'Name',
                      placeholder: 'Name',
                      controller: _nameController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'Email',
                      placeholder: 'Email',
                      controller: _emailController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'Phone Number',
                      placeholder: 'Phone',
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Add your 'Continue' button logic here
                          // Edit profile
                          String name = _nameController.text;
                          String email = _emailController.text;
                          String phoneNumber = _phoneNumberController.text;
                          String username = _usernameController.text;

                          // Create a map with the updated data
                          Map<String, dynamic> data = {
                            'name': name,
                            'email': email,
                            'phone': phoneNumber,
                            'username': username,
                          };

                          try {
                            // Update Firestore document using set() with merge option
                            await _firestore
                                .collection('Users')
                                .where("uid", isEqualTo: currentUser.uid)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              for (var doc in querySnapshot.docs) {
                                doc.reference.update(data);
                              }
                            });

                            // Data successfully updated
                            // Perform any desired actions here
                            const snackbar =
                                SnackBar(content: Text("Account Edited!"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } catch (error) {
                            // An error occurred while updating data
                            // Handle the error appropriately
                            final snackbar =
                                SnackBar(content: Text(error.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
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
