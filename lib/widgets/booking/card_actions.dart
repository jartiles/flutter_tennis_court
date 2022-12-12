import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/bookings_provider.dart';

import 'package:flutter_tennis_court/models/booking.dart';

class CardActions extends StatelessWidget {
  const CardActions({Key? key, required this.booking}) : super(key: key);

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: _DeleteBtn(booking: booking),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloudy_snowing, color: Color(0xFF5ac9fd)),
              const SizedBox(height: 5),
              Text(
                '${booking.probability!}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeleteBtn extends StatelessWidget {
  const _DeleteBtn({Key? key, required this.booking}) : super(key: key);
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDeleteConfirm(context, booking.id!),
      child: Icon(
        Icons.delete,
        size: 18,
        color: Colors.red.withOpacity(0.8),
      ),
    );
  }

  showDeleteConfirm(BuildContext context, int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Eliminar reserva'),
        content: const Text(
          'Al eliminar esta reserva se eliminará permanentemente. ¿Deseas continuar?',
          textAlign: TextAlign.justify,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              final bookingsProvider = Provider.of<BookingsProvider>(
                context,
                listen: false,
              );
              bookingsProvider.deleteBooking(id);
              Navigator.of(context).pop();
            },
            child: const Text('Continuar', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
