// To parse this JSON data, do
//
//     final sehir = sehirFromJson(jsonString);

import 'dart:convert';

List<Sehir> sehirFromJson(String str) => List<Sehir>.from(json.decode(str).map((x) => Sehir.fromJson(x)));

String sehirToJson(List<Sehir> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sehir {
  int id;
  String text;

  Sehir({
    required this.id,
    required this.text,
  });

  factory Sehir.fromJson(Map<String, dynamic> json) => Sehir(
    id: json["ID"],
    text: json["TEXT"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TEXT": text,
  };
}
