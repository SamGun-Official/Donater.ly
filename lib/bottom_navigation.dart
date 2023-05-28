import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/donater_screen/donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/home_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/my_donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  final Key? key; // Named 'key' parameter
  final Function(int) onItemTapped;
  static dynamic menu = DonaterHomeScreen();

  BottomNavigation({this.key, required this.onItemTapped}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();

  static dynamic getMenuByIndex(int index) {
    if (index == 0) {
      return DonaterHomeScreen();
    } else if (index == 1) {
      return DonaterDonationScreen();
    } else if (index == 2) {
      return DonaterMyDonationScreen();
    } else if (index == 3) {
      return ProfileScreen();
    }
    return DonaterHomeScreen(); // Default menu
  }
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onItemTapped(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      currentIndex: _selectedIndex,
      selectedItemColor: Color.fromRGBO(107, 147, 225, 1),
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
