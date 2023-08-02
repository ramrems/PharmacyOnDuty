// To parse this JSON data, do
//
//     final Ilce = IlceFromJson(jsonString);

import 'dart:convert';

List<Ilce> IlceFromJson(String str) => List<Ilce>.from(json.decode(str).map((x) => Ilce.fromJson(x)));

String IlceToJson(List<Ilce> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ilce {
  String city;
  String district;

  Ilce({
    required this.city,
    required this.district,
  });

  factory Ilce.fromJson(Map<String, dynamic> json) => Ilce(
    city: json["CITY"],
    district: json["DISTRICT"],
  );

  Map<String, dynamic> toJson() => {
    "CITY": city,
    "DISTRICT": district,
  };
}
