import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donaterly_app/models/donation.dart';
import 'package:donaterly_app/models/user_donation.dart';

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
            uniqueID: data.id,
          );
        }).toList());
  }
}
