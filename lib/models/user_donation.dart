class UserDonation {
  String? cvv;
  String donationDate;
  int donationID;
  String? expiredDate;
  String paymentMethod;
  int total;
  String userUID;

  UserDonation({
    required this.cvv,
    required this.donationDate,
    required this.donationID,
    required this.expiredDate,
    required this.paymentMethod,
    required this.total,
    required this.userUID,
  });
}
