import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/bottom_navigation.dart';

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

class DonaterDonationScreen extends StatefulWidget {
  static const routeName = '/donation';
  const DonaterDonationScreen({super.key});

  @override
  State<DonaterDonationScreen> createState() => _DonaterDonationScreenState();
}

class _DonaterDonationScreenState extends State<DonaterDonationScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'All';
  String selectedSort = 'Ascending';
  bool isFilterApplied = false;

  List<String> categoryList = ['All', 'Category 1', 'Category 2', 'Category 3'];
  List<String> sortList = ['Ascending', 'Descending'];
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
                        const Text(
                          'Donations',
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
                            child: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Select Category'),
                              content: Container(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: categoryList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(categoryList[index]),
                                      onTap: () {
                                        setState(() {
                                          selectedCategory =
                                              categoryList[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.list, size: 28),
                            SizedBox(width: 4),
                            Text('Category', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Select Sort'),
                              content: Container(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sortList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(sortList[index]),
                                      onTap: () {
                                        setState(() {
                                          selectedSort = sortList[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.sort, size: 28),
                            SizedBox(width: 4),
                            Text('Sort', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Filter'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: Text('By Title'),
                                    value: 'By Title',
                                    groupValue:
                                        isFilterApplied ? selectedSort : null,
                                    onChanged: (value) {
                                      setState(() {
                                        // selectedSort = value;
                                        isFilterApplied = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text('By Donation Raised'),
                                    value: 'By Donation Raised',
                                    groupValue:
                                        isFilterApplied ? selectedSort : null,
                                    onChanged: (value) {
                                      setState(() {
                                        // selectedSort = value;
                                        isFilterApplied = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.filter_alt, size: 28),
                            SizedBox(width: 4),
                            Text('Filter', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
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
      
    );
  }
}
