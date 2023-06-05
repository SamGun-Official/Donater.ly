import 'package:multiplatform_donation_app/models/saved_donation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();
  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'saved_donations';
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = await openDatabase(
      '$path/donations.db',
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          donationId INTEGER,
          userUid TEXT,
          createdAt TEXT
        )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertSavedDonation(SavedDonation savedDonation) async {
    final Database db = await database;
    await db.insert(_tableName, savedDonation.toMapWithoutId());
    print("Data inserted!");
  }

  Future<List<SavedDonation>> getSavedDonations() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (index) {
      return SavedDonation(
        id: maps[index]['id'],
        donationId: maps[index]['donationId'],
        userUid: maps[index]['userUid'],
        createdAt: maps[index]['createdAt'],
      );
    });
  }

  Future<void> removeSavedDonation(int donationId, String userUid) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'donationId = ? AND userUid = ?',
      whereArgs: [donationId, userUid],
    );
    print('Donasi dihapus dari saved donations');
  }

  Future<void> clearSavedDonations() async {
    final Database db = await database;
    await db.delete(_tableName);
    print("All data cleared from 'saved_donations' table!");
  }
}
