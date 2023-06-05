class SavedDonation {
  int? id;
  late int donationId;
  late String userUid;
  late String createdAt;

  SavedDonation({
    this.id,
    required this.donationId,
    required this.userUid,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "donationId": donationId,
      "userUid": userUid,
      "createdAt": createdAt
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'donationId': donationId,
      'userUid': userUid,
      'createdAt': createdAt,
    };
  }
  SavedDonation.formMap(Map<String, dynamic> map) {
    id = map["id"];
    donationId = map["donationId"];
    userUid = map["userUid"];
    createdAt = map["createdAt"];
  }
}
