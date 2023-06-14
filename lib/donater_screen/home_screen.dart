  import 'dart:ffi';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:multiplatform_donation_app/models/donation.dart';

  class CustomCard extends StatelessWidget {
    final String imagePath;
    final String title;
    final String subtitle;
    final int daysLeft;
    final double progress;
    final double collectedAmount;

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

  class ButtonRow extends StatefulWidget {
    final int selectedIndex;
    final Function(int) onButtonPressed;
    const ButtonRow({
      Key? key,
      required this.selectedIndex,
      required this.onButtonPressed,
    }) : super(key: key);

    @override
    _ButtonRowState createState() => _ButtonRowState();
  }

  class _ButtonRowState extends State<ButtonRow> {
    List<String> buttonLabels = ['All', 'Education', 'Food', 'Health', 'Animal'];

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                buttonLabels.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.onButtonPressed(
                            index); // Call the provided callback function
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.selectedIndex == index
                          ? Colors.blue
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      buttonLabels[index],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Margin bottom
        ],
      );
    }
  }

  class DonaterHomeScreen extends StatefulWidget {
    static const routeName = '/donater_home';
    const DonaterHomeScreen({Key? key});

    @override
    State<DonaterHomeScreen> createState() => _DonaterHomeScreenState();
  }

  class _DonaterHomeScreenState extends State<DonaterHomeScreen> {
    final _firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser!;
    late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
    TextEditingController _searchController = TextEditingController();
    String _searchKeyword = '';
    List<String> buttonLabels = ['All', 'Education', 'Food', 'Health', 'Animal'];
    int selectedIndex = 0;

    @override
    void initState() {
      super.initState();
      _stream = _firestore.collection('Donations').snapshots();
      _searchController.addListener(() {
        setState(() {
          _searchKeyword = _searchController.text.toLowerCase();
        });
      });
    }

    @override
    void dispose() {
      _searchController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: ListView(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: const Color.fromRGBO(107, 147, 225, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
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
                                    final userData =
                                        snapshot.data!.docs[0].data();
                                    return Row(
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            'images/profile.jpg',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            "Welcome, ${userData['name']}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: _firestore
                                  .collection('UserDonates')
                                  .where('userUID', isEqualTo: currentUser.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final userDonatesData = snapshot.data!.docs;
                                double totalDonation = 0;

                                for (var document in userDonatesData) {
                                  final donationData = document.data();
                                  final donationAmount = double.parse(
                                      donationData['total'].toString());
                                  totalDonation += donationAmount;
                                }

                                return FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.attach_money,
                                          color: Color.fromRGBO(107, 147, 225, 1),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Rp ${totalDonation.toStringAsFixed(0)} total donation',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey, // Change the icon color
                          ),
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: ButtonRow(
                          selectedIndex: selectedIndex,
                          onButtonPressed: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final filteredData = snapshot.data!.docs.where((document) {
                        final data = document.data();
                        final title = data['title'].toString().toLowerCase();
                        final subtitle =
                            data['subtitle'].toString().toLowerCase();
                        final category =
                            data['category'].toString().toLowerCase();
                        final filter_category = selectedIndex == 0 ||
                            category ==
                                (buttonLabels[selectedIndex].toLowerCase());
                        final filter_keyword = title.contains(_searchKeyword) ||
                            subtitle.contains(_searchKeyword);
                        return filter_category && filter_keyword;
                      });
                      return Column(
                        children: [
                          ...filteredData.map((document) {
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
                                collectedAmount: double.parse(
                                    data['collectedAmount'].toString()),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
