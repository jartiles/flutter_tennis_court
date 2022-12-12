import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/providers.dart';

import 'package:flutter_tennis_court/models/booking.dart';
import 'package:flutter_tennis_court/models/court.dart';

import 'date_rain.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({Key? key, required this.court}) : super(key: key);
  final Court court;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final bookingProvider = Provider.of<BookingsProvider>(context);

    BookingModel booking = formProvider.booking;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Form(
        key: formProvider.getFormKey,
        child: Column(
          children: [
            DateRainInput(courtId: court.id),
            const SizedBox(height: 20),
            _UserInput(booking: booking),
            const SizedBox(height: 50),
            formProvider.getLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text('Reservar'),
                    onPressed: () async {
                      if (!formProvider.isValidForm()) return;
                      booking.courtId = court.id;
                      booking.courtName = court.name;
                      await bookingProvider.createBooking(booking);
                      Navigator.pop(context);
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({super.key, required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: _inputDecoration(
        'Nombre reservante',
        Icons.account_circle,
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 4) {
          return 'El nombre del reservante es obligado';
        }
        return null;
      },
      onChanged: (value) => booking.userName = value,
    );
  }

  InputDecoration _inputDecoration(String title, IconData icon) {
    return InputDecoration(
      labelText: title,
      prefixIcon: Icon(icon),
    );
  }
}
