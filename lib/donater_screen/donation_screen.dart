import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/donater_screen/detail_screen.dart';
import 'package:multiplatform_donation_app/models/donation.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int daysLeft;
  final double progress;
  final int collectedAmount;

  const CustomCard({
    super.key,
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16),
                      const SizedBox(width: 4),
                      Text("$daysLeft days left"),
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
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(collectedAmount.toString()),
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
  String selectedCategory = 'All';
  String selectedSort = 'Ascending';
  bool isFilterApplied = false;
  String searchQuery = '';

  List<String> categoryList = ['All', 'Education', 'Food', 'Animal', 'Health'];
  List<String> sortList = ['Ascending', 'Descending'];

  final _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  void _showSearchPopup(BuildContext context) async {
    final searchQuery = await showSearch<String>(
      context: context,
      delegate: CustomSearchDelegate(),
    );

    if (searchQuery != null && searchQuery.isNotEmpty) {
      setState(() {
        this.searchQuery = searchQuery;
      });
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
                          child: InkWell(
                            onTap: () {
                              _showSearchPopup(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.search, color: Colors.black),
                            ),
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
                              title: const Text('Select Category'),
                              content: SizedBox(
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
                        child: const Row(
                          children: [
                            Icon(Icons.list, size: 28),
                            SizedBox(width: 4),
                            Text('Category', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select Sort'),
                              content: SizedBox(
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
                        child: const Row(
                          children: [
                            Icon(Icons.sort, size: 28),
                            SizedBox(width: 4),
                            Text('Sort', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Filter'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: const Text('By Title'),
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
                                    title: const Text('By Donation Raised'),
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
                        child: const Row(
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
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _firestore.collection('Donations').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var donations = snapshot.data!.docs;

                    if (searchQuery != "") {
                      donations = donations
                          .where((donation) =>
                              donation['title'].contains(searchQuery))
                          .toList();
                    }
                    if (selectedSort == "Ascending") {
                      donations
                          .sort((a, b) => (a['title']).compareTo(b['title']));
                    } else {
                      donations
                          .sort((a, b) => (b['title']).compareTo(a['title']));
                    }
                    if (selectedCategory != "All") {
                      donations = donations
                          .where((donation) =>
                              donation['category'] == selectedCategory)
                          .toList();
                    }
                    return Column(
                      children: [
                        ...donations.map((document) {
                          final data = document.data();
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/donater_detail',
                                  arguments: Donation(
                                    id: data['id'],
                                    imagePath: data['imagePath'],
                                    title: data['title'],
                                    subtitle: data['subtitle'],
                                    description: data['description'],
                                    fundraiser: data['fundraiser'],
                                    isFundraiserVerified:
                                        data['isFundraiserVerified'],
                                    daysLeft: data['daysLeft'],
                                    donaterCount: data['donaterCount'],
                                    progress: data['progress'],
                                    collectedAmount: data['collectedAmount'],
                                  ));
                            },
                            child: CustomCard(
                              imagePath: data['imagePath'],
                              title: data['title'],
                              subtitle: data['subtitle'],
                              daysLeft: data['daysLeft'],
                              progress: data['progress'],
                              collectedAmount: data['collectedAmount'],
                            ),
                          );
                        }),
                      ],
                    );
                  },
                  //doneTasks: _doneTodoList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform the search based on the query and display the results
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types in the search bar
    final suggestionList = query.isEmpty
        ? []
        : ['Result 1', 'Result 2', 'Result 3']
            .where((result) => result.startsWith(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
