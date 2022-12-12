import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/providers.dart';

class DateRainInput extends StatelessWidget {
  const DateRainInput({Key? key, required this.courtId}) : super(key: key);

  final String courtId;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final bookingProvider = Provider.of<BookingsProvider>(context);

    return Row(
      children: [
        Expanded(
          //- DateInput
          child: TextFormField(
            controller: formProvider.getDateController,
            readOnly: true,
            decoration:
                _inputDecoration('Fecha a reservar', Icons.calendar_month),
            validator: (value) {
              if (value == null || value == '') return 'La fecha es requerida';
              return null;
            },
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 16)),
              );
              if (pickedDate == null) return;
              formProvider.setDate = pickedDate;
              final courtUnavailable = await bookingProvider.dateAvailable(
                pickedDate,
                courtId,
              );
              if (courtUnavailable) {
                showAlert(context);
                formProvider.clearBooking();
              } else {
                formProvider.getProbability(pickedDate);
              }
            },
          ),
        ),
        //- Rain probability
        Container(
          width: 120,
          margin: const EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: formProvider.getRainController,
            enabled: false,
            decoration: _inputDecoration('% Lluvia', Icons.cloudy_snowing),
            validator: (value) {
              if (value == null || value == '') {
                return 'No se ha encontrando probabilidad';
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  showAlert(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Fecha no disponible'),
        content: const Text(
          'Se ha alcanzado el limite de 3 reservas diarias para esta cancha',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

InputDecoration _inputDecoration(String title, IconData icon) {
  return InputDecoration(
    labelText: title,
    prefixIcon: Icon(icon),
  );
}
