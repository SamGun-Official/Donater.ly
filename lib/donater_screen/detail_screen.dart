import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/bottom_navigation.dart';

class DonaterDetailScreen extends StatefulWidget {
  static const routeName = '/donater_detail';
  const DonaterDetailScreen({super.key});

  @override
  State<DonaterDetailScreen> createState() => _DonaterDetailScreenState();
}

class _DonaterDetailScreenState extends State<DonaterDetailScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        'Details',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
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
                          child:
                              Icon(Icons.bookmark_outline, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'images/detail_pic.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Help Children in Ambon Get Better Education',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: Icon(Icons.access_time, size: 20),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '20 Days Left',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius: 5.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'images/profile.png'), // Ganti dengan path foto profil pertama
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius: 5.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'images/profile.png'), // Ganti dengan path foto profil kedua
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius: 5.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                          'images/profile.png'), // Ganti dengan path foto profil ketiga
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '200+ donated',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Row(
                            children: [
                              Text(
                                'See More',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward, color: Colors.blue),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: const Text(
                        'Join us in making a difference through this donation account, where every contribution counts towards creating a brighter future for those in need. Together, let\'s spread hope and transform lives. #DonateForGood',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/profile.png'),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'The Donation',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Icon(Icons.check_circle,
                                          color: Colors.green),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Verified Public Donation',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
