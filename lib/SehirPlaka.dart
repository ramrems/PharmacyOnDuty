class SehirPlaka {
  final String sehir;
  final String plaka;

  SehirPlaka({required this.sehir,required this.plaka});

  factory SehirPlaka.fromJson(Map<String, dynamic> json) {
    return SehirPlaka(
      sehir: json['sehir'],
      plaka: json['plaka'],
    );
  }
}