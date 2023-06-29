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
  // ignore: library_private_types_in_public_api
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
        obscureText: true,
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

class DonaterEditPasswordScreen extends StatefulWidget {
  static const routeName = '/donater_edit_password';

  const DonaterEditPasswordScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DonaterEditPasswordScreenState createState() =>
      _DonaterEditPasswordScreenState();
}

class _DonaterEditPasswordScreenState extends State<DonaterEditPasswordScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Change Password',
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
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'Old Password',
                      placeholder: 'Old Password',
                      controller: _oldPasswordController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'New Password',
                      placeholder: 'New Password',
                      controller: _newPasswordController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldWithShadow(
                      label: 'Confirm New Password',
                      placeholder: 'Confirm New Password',
                      controller: _confirmPasswordController,
                      onChanged: (value) {
                        // Handle onChanged event
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Add your 'Continue' button logic here
                          // Edit profile
                          String oldPassword = _oldPasswordController.text;
                          String newPassword = _newPasswordController.text;
                          String confirmPassword =
                              _confirmPasswordController.text;

                          try {
                            // Validate password
                            if (newPassword.length < 8) {
                              throw Exception(
                                  'Password must be at least 8 characters long.');
                            } else if (!newPassword
                                .contains(RegExp(r'[A-Z]'))) {
                              throw Exception(
                                  'Password must contain at least one uppercase letter.');
                            } else if (!newPassword
                                .contains(RegExp(r'[a-z]'))) {
                              throw Exception(
                                  'Password must contain at least one lowercase letter.');
                            } else if (!newPassword
                                .contains(RegExp(r'[0-9]'))) {
                              throw Exception(
                                  'Password must contain at least one digit.');
                            }
                            // Verify if new password and confirm password match
                            else if (newPassword == confirmPassword) {
                              // Re-authenticate user with current password
                              AuthCredential credential =
                                  EmailAuthProvider.credential(
                                email: currentUser.email!,
                                password: oldPassword,
                              );
                              await currentUser
                                  .reauthenticateWithCredential(credential);

                              // Update password
                              await currentUser.updatePassword(newPassword);

                              // Password successfully updated
                              // Perform any desired actions here
                              const snackbar =
                                  SnackBar(content: Text("Password Updated!"));
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);

                              // Clear text fields
                              _oldPasswordController.clear();
                              _newPasswordController.clear();
                              _confirmPasswordController.clear();
                            } else {
                              // New password and confirm password do not match
                              const snackbar = SnackBar(
                                  content: Text("Passwords do not match!"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          } on Exception catch (e) {
                            final snackbar =
                                SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } finally {}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Continue'),
                        ),
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Cancel'),
                        ),
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
