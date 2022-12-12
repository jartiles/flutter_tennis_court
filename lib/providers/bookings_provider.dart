import 'package:flutter/material.dart';

import 'package:flutter_tennis_court/providers/db_provider.dart';

import 'package:flutter_tennis_court/models/booking.dart';

class BookingsProvider extends ChangeNotifier {
  GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  List<BookingModel> bookingsList = [];

  BookingsProvider() {
    loadAll();
  }

  Future loadAll() async {
    final bookingsDB = await DBProvider.db.loadBookings();
    bookingsList = [...bookingsDB];
    notifyListeners();
  }

  Future createBooking(BookingModel booking) async {
    await DBProvider.db.insertBooking(booking);
    showSnackBar('Reserva guardada', Colors.green);
    loadAll();
  }

  Future deleteBooking(int id) async {
    await DBProvider.db.deleteBooking(id);
    showSnackBar('Reserva eliminada', Colors.redAccent);
    loadAll();
  }

  Future<bool> dateAvailable(DateTime date, String courtId) async {
    final res = await DBProvider.db.validateDate(
      date.toString().substring(0, 10),
      courtId,
    );
    return res >= 3;
  }

  showSnackBar(String message, Color color) {
    final snack = SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    scaffoldKey.currentState?.showSnackBar(snack);
  }
}
