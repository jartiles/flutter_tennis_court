import 'dart:convert';

class BookingModel {
  int? id;
  String? date;
  String? courtId;
  String? courtName;
  String? probability;
  String userName;

  BookingModel({
    this.id,
    this.date,
    this.courtId,
    this.courtName,
    this.probability,
    required this.userName,
  });

  factory BookingModel.fromJson(String str) =>
      BookingModel.fromMap(json.decode(str));

  factory BookingModel.fromMap(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        date: json["date"],
        courtId: json["courtId"],
        courtName: json["courtName"],
        probability: json["probability"],
        userName: json["userName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "courtId": courtId,
        "courtName": courtName,
        "probability": probability,
        "userName": userName,
      };
}
