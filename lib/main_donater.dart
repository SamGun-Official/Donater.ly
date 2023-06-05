import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/bottom_navigation.dart';
import 'package:multiplatform_donation_app/donater_screen/detail_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/donate_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/edit_profile_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/home_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/my_donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/profile_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/saved_donation_screen.dart';
import 'package:multiplatform_donation_app/donater_screen/transaction_screen.dart';
import 'package:multiplatform_donation_app/provider/db_provider.dart';
import 'package:provider/provider.dart';

class MainDonater extends StatefulWidget {
  static const routeName = '/main_donater';

  const MainDonater({Key? key}) : super(key: key);

  @override
  State<MainDonater> createState() => _MainDonaterState();
}

class _MainDonaterState extends State<MainDonater> {
  dynamic menu = BottomNavigation.menu;

  void _onItemTapped(int index) {
    setState(() {
      BottomNavigation.menu = BottomNavigation.getMenuByIndex(index);
      menu = BottomNavigation.menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DbProvider()),
      ],
      child: MaterialApp(
          title: 'Main Donater',
          theme: ThemeData(
            primaryColor: Colors.white, // Replace with your desired color
          ),
          home: Scaffold(
            body: GestureDetector(
              onTap: () => setState(() {
                menu = BottomNavigation.menu;
              }),
              child: menu,
            ),
            bottomNavigationBar: BottomNavigation(
              onItemTapped: _onItemTapped,
            ),
          ),
          routes: {
            //Donater
            DonaterHomeScreen.routeName: (context) => const DonaterHomeScreen(),
            DonaterDetailScreen.routeName: (context) =>
                const DonaterDetailScreen(),
            DonaterDonateScreen.routeName: (context) =>
                const DonaterDonateScreen(),
            DonaterDonationScreen.routeName: (context) =>
                const DonaterDonationScreen(),
            DonaterEditProfileScreen.routeName: (context) =>
                DonaterEditProfileScreen(),
            DonaterMyDonationScreen.routeName: (context) =>
                DonaterMyDonationScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            DonaterSavedDonationScreen.routeName: (context) =>
                DonaterSavedDonationScreen(),
            DonaterTransactionScreen.routeName: (context) =>
                DonaterTransactionScreen(),
            MainDonater.routeName: (context) => const MainDonater(),
          }),
    );
  }
}
