import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

class DonaterHomeScreen extends StatefulWidget {
  static const routeName = '/donater_home';
  const DonaterHomeScreen({super.key});

  @override
  State<DonaterHomeScreen> createState() => _DonaterHomeScreenState();
}

class _DonaterHomeScreenState extends State<DonaterHomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ListView(
              children: [
                SizedBox(
                  //container card
                  width: double.infinity,
                  child: Card(
                    color: const Color.fromRGBO(
                        107, 147, 225, 1), // Ubah warna card sesuai kebutuhan
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Ubah nilai border radius sesuai kebutuhan
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                final userData = snapshot.data!.docs[0].data();
                                return Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
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
                              }),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.89,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.attach_money,
                                        color:
                                            Color.fromRGBO(107, 147, 225, 1)),
                                    SizedBox(width: 4),
                                    Text(
                                      'Rp 1.500.000 total donation',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Urgent Causes',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    return Column(children: [
                      ...snapshot.data!.docs.map((document) {
                        final data = document.data();
                        return CustomCard(
                          imagePath: data['imagePath'],
                          title: data['title'],
                          subtitle: data['subtitle'],
                          daysLeft: data['daysLeft'],
                          progress: data['progress'],
                          collectedAmount: data['collectedAmount'],
                        );
                      })
                    ]);
                  },
                  //doneTasks: _doneTodoList,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
