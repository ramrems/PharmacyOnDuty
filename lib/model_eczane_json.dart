// To parse this JSON data, do
//
//     final pharmacy = pharmacyFromJson(jsonString);

import 'dart:convert';

Pharmacy pharmacyFromJson(String? str) => Pharmacy.fromJson(json.decode(str!));

String pharmacyToJson(Pharmacy data) => json.encode(data.toJson());

class Pharmacy {
  String status;
  String message;
  int rowCount;
  List<dynamic> data;

  Pharmacy({
    required this.status,
    required this.message,
    required this.rowCount,
    required this.data,
  });

  factory Pharmacy.fromJson(Map<String?, dynamic> json) => Pharmacy(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    rowCount: json['rowCount'] is int ? json['rowCount'] : 0,
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "rowCount": rowCount,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}

class DatumClass {
  String eczaneAdi;
  String adresi;
  String semt;
  String yolTarifi;
  String telefon;
  String telefon2;
  String sehir;
  String ilce;
  double latitude;
  double longitude;

  DatumClass({
    required this.eczaneAdi,
    required this.adresi,
    required this.semt,
    required this.yolTarifi,
    required this.telefon,
    required this.telefon2,
    required this.sehir,
    required this.ilce,
    required this.latitude,
    required this.longitude,
  });

  factory DatumClass.fromJson(Map<String, dynamic> json) => DatumClass(
    eczaneAdi: json["EczaneAdi"] ??'',
    adresi: json["Adresi"]  ??'',
    semt: json["Semt"]  ??'',
    yolTarifi: json["YolTarifi"] ??'',
    telefon: json["Telefon"]  ??'',
    telefon2: json["Telefon2"] ??'',
    sehir: json["Sehir"] ??'',
    ilce: json["ilce"] ??'',
    latitude: json["latitude"].toDouble() ?? 0,
    longitude: json["longitude"]?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "EczaneAdi": eczaneAdi,
    "Adresi": adresi,
    "Semt": semt,
    "YolTarifi": yolTarifi,
    "Telefon": telefon,
    "Telefon2": telefon2,
    "Sehir": sehir,
    "ilce": ilce,
    "latitude": latitude,
    "longitude": longitude,
  };
}
