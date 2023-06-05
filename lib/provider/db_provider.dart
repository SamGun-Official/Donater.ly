import 'package:flutter/material.dart';
import 'package:multiplatform_donation_app/models/saved_donation.dart';
import 'package:multiplatform_donation_app/utils/database_helper.dart';

class DbProvider extends ChangeNotifier {
  final List<SavedDonation> _arrSavedDonation = [];
  late DatabaseHelper _dbHelper;
  List<SavedDonation> get savedDonations => _arrSavedDonation;
  DbProvider() {
    _dbHelper = DatabaseHelper();
    getSavedDonations();
  }
  Future<void> addSavedDonation(SavedDonation savedDonation) async {
    await _dbHelper.insertSavedDonation(savedDonation);
  }

  Future<void> getSavedDonations() async {
    _arrSavedDonation.clear();
    final DatabaseHelper dbHelper = DatabaseHelper();
    final List<SavedDonation> donations = await dbHelper.getSavedDonations();
    _arrSavedDonation.addAll(donations);
    notifyListeners();
  }

  Future<void> removeSavedDonation(int donationId, String userUid) async {
    await _dbHelper.removeSavedDonation(donationId, userUid);
    await getSavedDonations(); // Refresh daftar savedDonations setelah menghapus donasi
  }
}
