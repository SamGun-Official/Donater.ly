import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiplatform_donation_app/models/donation.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

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
                  Text(currencyFormat.format(collectedAmount)),
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
  String? selectedSort = 'Ascending';
  String? selectedFilterChoose;
  String latestKeyword = "";
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

  String filterByTitleQuery = '';
  String? selectedFilterRange;
  RangeValues selectedFilterRangeValues = const RangeValues(0, 1000000);
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _showFilterPopup(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('By Title'),
              value: 'By Title',
              groupValue: isFilterApplied ? selectedFilterChoose : null,
              onChanged: (value) {
                setState(() {
                  selectedFilterChoose = value;
                });
                Navigator.pop(context);
                if (selectedFilterChoose == 'By Title') {
                  _showTitleFilterDialog();
                }
              },
            ),
            RadioListTile(
              title: const Text('By Donation Raised'),
              value: 'By Donation Raised',
              groupValue: isFilterApplied ? selectedFilterChoose : null,
              onChanged: (value) {
                setState(() {
                  selectedFilterChoose = value;
                });
                Navigator.pop(context);
                if (selectedFilterChoose == 'By Donation Raised') {
                  _showRangeFilterDialog();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTitleFilterDialog() async {
    final titleQuery = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter by Title'),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Enter title'),
          onChanged: (value) {
            setState(() {
              filterByTitleQuery = value;
            });
          },
          controller: _keywordController,
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // selectedSort = 'Ascending';
                filterByTitleQuery = '';
              });
            },
          ),
          TextButton(
            child: const Text('Apply'),
            onPressed: () {
              Navigator.pop(context, filterByTitleQuery);
            },
          ),
        ],
      ),
    );

    if (titleQuery != null) {
      setState(() {
        filterByTitleQuery = titleQuery;
      });
    }
  }

  void _showRangeFilterDialog() async {
    final selectedRange = await showDialog<RangeValues>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter by Donation Raised'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RangeSlider(
                  values: selectedFilterRangeValues,
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  onChanged: (RangeValues values) {
                    setState(() {
                      selectedFilterRangeValues = values;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '\$${currencyFormat.format(selectedFilterRangeValues.start.round())}'),
                    Text(
                        '\$${currencyFormat.format(selectedFilterRangeValues.end.round())}'),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                selectedFilterRangeValues = const RangeValues(0, 1000000);
              });
            },
          ),
          TextButton(
            child: const Text('Apply'),
            onPressed: () {
              Navigator.pop(context, selectedFilterRangeValues);
            },
          ),
        ],
      ),
    );

    if (selectedRange != null) {
      setState(() {
        selectedFilterRangeValues = selectedRange;
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
                          _showFilterPopup(context);
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
                    debugPrint(snapshot.toString());
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var donations = snapshot.data!.docs;
                    if (filterByTitleQuery != "") {
                      donations = donations
                          .where((donation) => donation['title']
                              .toString()
                              .toLowerCase()
                              .contains(filterByTitleQuery.toLowerCase()))
                          .toList();
                    }
                    if (searchQuery != "") {
                      donations = donations
                          .where((donation) => donation['title']
                              .toString()
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .toList();
                    }
                    donations = donations
                        .where((donation) =>
                            donation['collectedAmount'] >=
                                selectedFilterRangeValues.start &&
                            donation['collectedAmount'] <=
                                selectedFilterRangeValues.end)
                        .toList();
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
                                      donationNeeded: data['donationNeeded']));
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
          showResults(context);
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
    final firestore = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firestore.collection('Donations').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var donations = snapshot.data!.docs;

        donations = donations
            .where((donation) =>
                donation['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();

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
                          isFundraiserVerified: data['isFundraiserVerified'],
                          daysLeft: data['daysLeft'],
                          donaterCount: data['donaterCount'],
                          progress: data['progress'],
                          collectedAmount: data['collectedAmount'],
                          donationNeeded: data['donationNeeded']));
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
