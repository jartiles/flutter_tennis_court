import 'package:flutter/material.dart';

import 'package:flutter_tennis_court/models/booking.dart';

import 'package:flutter_tennis_court/theme/custom_theme.dart';

import 'package:flutter_tennis_court/widgets/booking/card_actions.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({Key? key, required this.booking}) : super(key: key);

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: CustomTheme.cardStyle,
      child: Row(
        children: [
          _CardImage(courtId: booking.courtId!),
          Expanded(
            child: _CardData(booking: booking),
          ),
          CardActions(booking: booking)
        ],
      ),
    );
  }
}

class _CardData extends StatelessWidget {
  const _CardData({Key? key, required this.booking}) : super(key: key);

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          booking.courtName!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          booking.date!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          'Reserva: ${booking.userName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({Key? key, required this.courtId}) : super(key: key);

  final String courtId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image(
        image: AssetImage(_returnImageRoute(courtId)),
        fit: BoxFit.contain,
        height: 100,
        width: 80,
      ),
    );
  }

  String _returnImageRoute(String id) {
    switch (id) {
      case 'A':
        return 'assets/grass.jpg';
      case 'B':
        return 'assets/clay.jpg';
      case 'C':
        return 'assets/hard.jpg';
      default:
        return 'assets/grass.jpg';
    }
  }
}
