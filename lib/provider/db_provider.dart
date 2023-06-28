import 'package:flutter/foundation.dart';
import 'package:multiplatform_donation_app/models/saved_donation.dart';
import 'package:multiplatform_donation_app/utils/database_helper.dart';

class DbProvider extends ChangeNotifier {
  final List<SavedDonation> _arrSavedDonation = [];
  late DatabaseHelper _dbHelper;
  List<SavedDonation> get savedDonations => _arrSavedDonation;
  DbProvider() {
    _dbHelper = DatabaseHelper();
    getSavedDonations();
    clearSavedDonations();
  }
  Future<void> addSavedDonation(SavedDonation savedDonation) async {
    if (!kIsWeb) {
      await _dbHelper.insertSavedDonation(savedDonation);
      await getSavedDonations();
    }
  }

  Future<void> getSavedDonations() async {
    if (!kIsWeb) {
      _arrSavedDonation.clear();
      final DatabaseHelper dbHelper = DatabaseHelper();
      final List<SavedDonation> donations = await dbHelper.getSavedDonations();
      _arrSavedDonation.addAll(donations);
      notifyListeners();
    }
  }

  Future<void> removeSavedDonation(int donationId, String userUid) async {
    if (!kIsWeb) {
      await _dbHelper.removeSavedDonation(donationId, userUid);
      await getSavedDonations(); // Refresh daftar savedDonations setelah menghapus donasi
    }
  }

  Future<void> clearSavedDonations() async {
    if (!kIsWeb) {
      await _dbHelper.clearSavedDonations();
      await getSavedDonations();
    }
  }
}
