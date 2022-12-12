import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/bookings_provider.dart';

import 'package:flutter_tennis_court/widgets/widgets.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = Provider.of<BookingsProvider>(context);
    final bookingsList = bookingsProvider.bookingsList;

    return Scaffold(
      body: bookingsList.isEmpty
          ? const _BookingsEmpty()
          : RefreshIndicator(
              onRefresh: () => bookingsProvider.loadAll(),
              child: ListView.builder(
                itemCount: bookingsList.length,
                itemBuilder: (context, index) => BookingCard(
                  booking: bookingsList[index],
                ),
              ),
            ),
    );
  }
}

class _BookingsEmpty extends StatelessWidget {
  const _BookingsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Haz tu primera reserva desde la opción canchas, selecciona la cacha de tu gusto y rellena los datos',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        const Image(
          image: AssetImage('assets/storyset_bg.png'),
          height: 200,
          width: 250,
        )
      ],
    );
  }
}
