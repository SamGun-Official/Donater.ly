import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:donaterly_app/donater_screen/donation_screen.dart';
import 'package:donaterly_app/models/donation.dart';
import 'package:donaterly_app/provider/db_provider.dart';
import 'package:provider/provider.dart';

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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
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

class DonaterSavedDonationScreen extends StatefulWidget {
  static const routeName = '/donater_saved_donation';

  const DonaterSavedDonationScreen({super.key});
  @override
  State<DonaterSavedDonationScreen> createState() =>
      _DonaterSavedDonationScreenState();
}

class _DonaterSavedDonationScreenState
    extends State<DonaterSavedDonationScreen> {
  final _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context, listen: false);

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
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                      ),
                      const Text(
                        'Saved Donations',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
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
                      return Column(children: [
                        ...donations.map((document) {
                          final data = document.data();
                          if (dbProvider.savedDonations.any((savedDonation) {
                            return savedDonation.donationId == data['id'] &&
                                savedDonation.userUid == currentUser.uid;
                          })) {
                            return InkWell(
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, '/donater_detail',
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
                                        progress: double.parse(
                                            data['progress'].toString()),
                                        collectedAmount:
                                            data['collectedAmount'],
                                        donationNeeded: data['donationNeeded'],
                                        category: data['category']));
                                setState(() {});
                              },
                              child: CustomCard(
                                imagePath: data['imagePath'],
                                title: data['title'],
                                subtitle: data['subtitle'],
                                daysLeft: data['daysLeft'],
                                progress:
                                    double.parse(data['progress'].toString()),
                                collectedAmount: data['collectedAmount'],
                              ),
                            );
                          }
                          return const SizedBox(height: 5);
                        }),
                      ]);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
