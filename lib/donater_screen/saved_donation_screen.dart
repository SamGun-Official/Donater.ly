import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String daysLeft;
  final double progress;
  final String collectedAmount;

  const CustomCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.daysLeft,
    required this.progress,
    required this.collectedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16),
                      const SizedBox(width: 4),
                      Text(daysLeft),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(collectedAmount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonaterSavedDonationScreen extends StatefulWidget {
  @override
  State<DonaterSavedDonationScreen> createState() =>
      _DonaterSavedDonationScreenState();
}

class _DonaterSavedDonationScreenState
    extends State<DonaterSavedDonationScreen> {
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
                          'Saved Donations',
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
                CustomCard(
                  imagePath: 'images/detail_pic.jpg',
                  title: 'Many Children Need Food to Survive',
                  subtitle: 'The Unity',
                  daysLeft: '20 days left',
                  progress: 0.2,
                  collectedAmount: 'Collected Rp 150.000,00',
                ),
                const SizedBox(height: 16),
                CustomCard(
                  imagePath: 'images/detail_pic.jpg',
                  title: 'Build a school to study',
                  subtitle: 'Another Subtitle',
                  daysLeft: '10 days left',
                  progress: 0.5,
                  collectedAmount: 'Collected Rp 200.000,00',
                ),
                const SizedBox(height: 16),
                CustomCard(
                  imagePath: 'images/detail_pic.jpg',
                  title: 'Build a school to study',
                  subtitle: 'Another Subtitle',
                  daysLeft: '10 days left',
                  progress: 0.5,
                  collectedAmount: 'Collected Rp 200.000,00',
                ),
                const SizedBox(height: 16),
                CustomCard(
                  imagePath: 'images/detail_pic.jpg',
                  title: 'Build a school to study',
                  subtitle: 'Another Subtitle',
                  daysLeft: '10 days left',
                  progress: 0.5,
                  collectedAmount: 'Collected Rp 200.000,00',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(107, 147, 225, 1),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
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
        ),
      ),
    );
  }
}
