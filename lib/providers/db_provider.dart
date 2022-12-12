import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter_tennis_court/models/booking.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider();

  Future<Database> get getDatabase async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'bookings.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE bookings(id INTEGER PRIMARY KEY, date TEXT, courtId TEXT, courtName TEXT, probability TEXT, userName TEXT)',
        );
      },
    );
  }

  Future<List> loadBookings() async {
    final db = await getDatabase;
    final res = await db.query('bookings', orderBy: 'date');
    return res.isEmpty ? [] : res.map((e) => BookingModel.fromMap(e)).toList();
  }

  Future<int> insertBooking(BookingModel booking) async {
    final db = await getDatabase;
    final res = await db.insert('bookings', booking.toMap());
    return res;
  }

  Future<int> deleteBooking(int id) async {
    final db = await getDatabase;
    final res = await db.delete('bookings', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> validateDate(String date, String courtId) async {
    final db = await getDatabase;
    final res = Sqflite.firstIntValue(await db.query(
      'bookings',
      columns: ['COUNT(*)'],
      where: 'date = ? AND courtId = ?',
      whereArgs: [date, courtId],
    ));
    return res ?? 0;
  }
}
