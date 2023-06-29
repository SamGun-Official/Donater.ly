import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiplatform_donation_app/models/donation.dart';
import 'package:multiplatform_donation_app/models/user_donation.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int collectedAmount;
  final String donationDate;
  final int donationID;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.collectedAmount,
    required this.donationDate,
    required this.donationID,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(context, '/donater_detail',
            arguments: await DataFetch.getDonationData(donationID));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                ),
              ),
              Flexible(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        subtitle,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        "Amount: ${NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp',
                        ).format(collectedAmount)}",
                      ),
                    ),
                    Text("Donated On: $donationDate"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, int> groupAndCountDonationsByType(List<Donation> donations) {
  Map<String, int> countMap = {};
  for (var donation in donations) {
    if (countMap.containsKey(donation.category)) {
      countMap[donation.category!] = countMap[donation.category]! + 1;
    } else {
      countMap[donation.category!] = 1;
    }
  }
  for (var donation in donations) {
    if (!countMap.containsKey(donation.category)) {
      countMap[donation.category!] = 0;
    }
  }
  return countMap;
}

Widget buildGridItem(String imagePath, String type) {
  return StreamBuilder<List<UserDonation>>(
    stream:
        DataFetch.retrieveUserDonations(FirebaseAuth.instance.currentUser!.uid),
    builder: (streamContext, streamSnapshot) {
      if (streamSnapshot.hasData) {
        final List<UserDonation> userDonations = streamSnapshot.data!;
        final List<int> donationIDs = userDonations
            .map((userDonation) => userDonation.donationID)
            .toList();
        return FutureBuilder<List<Donation>>(
          future: fetchDonations(donationIDs),
          builder: (futureContext, futureSnapshot) {
            if (futureSnapshot.hasData) {
              final List<Donation> donations = futureSnapshot.data!;
              final Map<String, int> donationCounts =
                  groupAndCountDonationsByType(donations);
              final int count = donationCounts[type] ?? 0;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          count.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "$type Donation${count > 1 ? 's' : ''}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (futureSnapshot.hasError) {
              return Text('${futureSnapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      } else if (streamSnapshot.hasError) {
        return Text('${streamSnapshot.error}');
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

Future<List<Donation>> fetchDonations(List<int> donationIDs) async {
  final List<Future<Donation>> donationFutures =
      donationIDs.map((id) => DataFetch.getDonationData(id)).toList();

  return await Future.wait(donationFutures);
}

class DonaterMyDonationScreen extends StatefulWidget {
  static const routeName = '/donater_my_donation';

  const DonaterMyDonationScreen({super.key});
  @override
  State<DonaterMyDonationScreen> createState() =>
      _DonaterMyDonationScreenState();
}

class _DonaterMyDonationScreenState extends State<DonaterMyDonationScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

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
                const SizedBox(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'My Donations',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 18.0,
                    bottom: 12.0,
                    left: 4.0,
                    right: 4.0,
                  ),
                  child: Text(
                    'Donations By Categories',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                GridView.count(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: buildGridItem(
                          'images/education_donation.jpg',
                          'Education',
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: buildGridItem(
                          'images/food_donation.jpg',
                          'Food',
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: buildGridItem(
                          'images/health_donation.jpg',
                          'Health',
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: buildGridItem(
                          'images/animal_donation.jpg',
                          'Animal',
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    bottom: 12.0,
                    left: 4.0,
                    right: 4.0,
                  ),
                  child: Text(
                    'All Past Donations',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                StreamBuilder<List<UserDonation>>(
                  stream: DataFetch.retrieveUserDonations(currentUser.uid),
                  builder: (streamContext, streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      final List<UserDonation> userDonations =
                          streamSnapshot.data!;
                      return Wrap(
                        children: userDonations.map((userDonation) {
                          return FutureBuilder<Donation>(
                            future: DataFetch.getDonationData(
                                userDonation.donationID),
                            builder: (futureContext, futureSnapshot) {
                              if (futureSnapshot.hasData) {
                                final Donation donation = futureSnapshot.data!;
                                return CustomCard(
                                  imagePath: donation.imagePath,
                                  title: donation.title,
                                  subtitle: donation.subtitle,
                                  collectedAmount: userDonation.total,
                                  donationDate: userDonation.donationDate,
                                  donationID: userDonation.donationID,
                                );
                              } else if (futureSnapshot.hasError) {
                                return Text('${futureSnapshot.error}');
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        }).toList(),
                      );
                    } else if (streamSnapshot.hasError) {
                      return Text('${streamSnapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataFetch {
  static Future<Donation> getDonationData(int id) async {
    final QuerySnapshot<Map<String, dynamic>> donationSnapshot =
        await FirebaseFirestore.instance
            .collection("Donations")
            .where("id", isEqualTo: id)
            .get();

    if (donationSnapshot.docs.isNotEmpty) {
      final donationData = donationSnapshot.docs[0].data();
      final imagePath = donationData["imagePath"];
      final title = donationData["title"];
      final subtitle = donationData["subtitle"];
      final description = donationData["description"];
      final fundraiser = donationData["fundraiser"];
      final isFundraiserVerified = donationData["isFundraiserVerified"];
      final daysLeft = donationData["daysLeft"];
      final donaterCount = donationData["donaterCount"];
      final progress = donationData["progress"];
      final collectedAmount = donationData["collectedAmount"];
      final donationNeeded = donationData["donationNeeded"];
      final category = donationData["category"];

      return Donation(
        id: id,
        imagePath: imagePath,
        title: title,
        subtitle: subtitle,
        description: description,
        fundraiser: fundraiser,
        isFundraiserVerified: isFundraiserVerified,
        daysLeft: daysLeft,
        donaterCount: donaterCount,
        progress: progress,
        collectedAmount: collectedAmount,
        donationNeeded: donationNeeded,
        category: category,
      );
    }

    throw Exception("No matching donation found");
  }

  static Stream<List<UserDonation>> retrieveUserDonations(String userUID) {
    final querySnapshot = FirebaseFirestore.instance
        .collection("UserDonates")
        .where("userUID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("donationTimestamp", descending: true)
        .snapshots();

    return querySnapshot.map((list) => list.docs.map((data) {
          return UserDonation(
            cvv: data["CVV"],
            donationDate: data["donationDate"],
            donationID: data["donationID"],
            expiredDate: data["expiredDate"],
            paymentMethod: data["paymentMethod"],
            total: data["total"].round(),
            userUID: data["userUID"],
          );
        }).toList());
  }
}
