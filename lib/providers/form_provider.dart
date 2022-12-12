import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_tennis_court/models/booking.dart';

class FormProvider extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _rainController = TextEditingController();

  BookingModel booking = BookingModel(userName: '');

  //- location
  final location = Location();
  double lat = 10.48576;
  double long = -66.8925952;

  //- probability
  final _baseUrl = 'api.weatherbit.io';
  final _key = 'YOUR-TOKEN';
  bool _isLoading = false;

  FormProvider() {
    _initLocationService();
  }

  get getFormKey => _formKey;
  get getDateController => _dateController;
  get getRainController => _rainController;
  get getLoading => _isLoading;

  set setDate(DateTime date) {
    booking.date = date.toString().substring(0, 10);
    _dateController.text = date.toString().substring(0, 10);
  }

  clearBooking() {
    _dateController.text = '';
    _rainController.text = '';
  }

  bool isValidForm() => _formKey.currentState?.validate() ?? false;

  Future getProbability(DateTime pickedDate) async {
    _isLoading = true;
    notifyListeners();
    //- date diff to make the request
    final DateTime now = DateTime.now();
    final DateTime date = DateTime(now.year, now.month, now.day);
    final diff = pickedDate.difference(date).inDays;
    //- Request
    final url = Uri.https(_baseUrl, '/v2.0/forecast/daily', {
      'lat': lat.toString(),
      'lon': long.toString(),
      'days': '${diff + 1}',
      'key': _key
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      final probability = json['data'][diff]['pop'].toString();
      _rainController.text = probability;
      booking.probability = probability;
    } else {
      _rainController.text = '0';
    }
    _isLoading = false;
    notifyListeners();
  }

  //- get location
  Future _initLocationService() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    lat = locationData.latitude ?? 10.48576;
    long = locationData.longitude ?? -66.8925952;
  }
}
