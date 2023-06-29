import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:donaterly_app/models/donation.dart';
import 'package:donaterly_app/models/saved_donation.dart';
import 'package:donaterly_app/provider/db_provider.dart';

class DonaterDetailScreen extends StatefulWidget {
  static const routeName = '/donater_detail';
  const DonaterDetailScreen({super.key});

  @override
  State<DonaterDetailScreen> createState() => _DonaterDetailScreenState();
}

class _DonaterDetailScreenState extends State<DonaterDetailScreen> {
  final String donationTitle = 'Education Fund';
  final double donationProgress = 0.6;
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isDonationExists = false;
  Donation? donation;
  void updateDonation(Donation updatedDonation) {
    setState(() {
      donation = updatedDonation;
    });
  }

  @override
  Widget build(BuildContext context) {
    donation ??= ModalRoute.of(context)!.settings.arguments as Donation;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    final dbProvider = Provider.of<DbProvider>(context, listen: false);
    isDonationExists = dbProvider.savedDonations.any((savedDonation) {
      return savedDonation.donationId == donation!.id &&
          savedDonation.userUid == currentUser.uid;
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        'Details',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () async {
                          if (!kIsWeb) {
                            isDonationExists =
                                dbProvider.savedDonations.any((savedDonation) {
                              return savedDonation.donationId == donation!.id &&
                                  savedDonation.userUid == currentUser.uid;
                            });

                            // Cek apakah donasi sudah ada pada saved donation
                            if (isDonationExists) {
                              await dbProvider
                                  .removeSavedDonation(
                                      donation!.id, currentUser.uid)
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Berhasil hapus donasi dari daftar saved donations!',
                                    ),
                                  ),
                                );
                                setState(() {
                                  isDonationExists = false;
                                });
                              });
                            } else {
                              await dbProvider
                                  .addSavedDonation(SavedDonation(
                                donationId: donation!.id,
                                userUid: currentUser.uid,
                                createdAt: Timestamp.now().toString(),
                              ))
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Berhasil tambah donasi ke daftar saved donations!',
                                    ),
                                  ),
                                );
                                setState(() {
                                  isDonationExists = true;
                                });
                              });
                            }
                          } else {
                            // Web, need firestore
                          }
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
                          child: CircleAvatar(
                            backgroundColor: isDonationExists
                                ? Colors.blue[400]
                                : Colors.white,
                            child: Icon(
                              isDonationExists
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: isDonationExists
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            donation!.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        donation!.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Opacity(
                            opacity: 0.6,
                            child: Icon(Icons.access_time, size: 20),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${donation!.daysLeft} days left",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Stack(
                                children: List.generate(
                                    donation!.donaterCount >= 3
                                        ? 3
                                        : donation!.donaterCount, (index) {
                                  return Positioned(
                                    left: 30.0 * index,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            blurRadius: 5.0,
                                            spreadRadius: 2.0,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            'images/profile.png'), // Ganti dengan path foto profil
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${donation!.donaterCount}+ donated',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          donation!.description,
                          style: const TextStyle(fontSize: 16),
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
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/profile.png'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              donation!.fundraiser,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      donation!.isFundraiserVerified
                                          ? 'Verified Public Donation'
                                          : 'Unverified Public Donation',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (donation!.isFundraiserVerified)
                                const Icon(Icons.check_circle,
                                    color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      const Text(
                        'Donation Goals',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: donation!.progress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(donation!.progress * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Collected: ${currencyFormat.format(donation!.collectedAmount)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (donation!.progress >= 1.0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Donation Closed'),
                                        content: const Text(
                                            'Donasi sudah mencapai batas maksimal!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.pushNamed(
                                      context, "/donater_donate",
                                      arguments: {
                                        'donation': donation,
                                        'updateDonation': (updatedDonation) {
                                          updateDonation(updatedDonation);
                                        },
                                      });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('Proceed to Donate'),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
