class UserDonation {
  String? cvv;
  String donationDate;
  int donationID;
  String? expiredDate;
  String paymentMethod;
  int total;
  String userUID;
  String uniqueID;

  UserDonation({
    required this.cvv,
    required this.donationDate,
    required this.donationID,
    required this.expiredDate,
    required this.paymentMethod,
    required this.total,
    required this.userUID,
    required this.uniqueID,
  });
}
