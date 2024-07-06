import 'dart:convert';

class Country {
  final String name;
  final String capital;
  final String region;
  final String flag;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: json['capital'] != null ? json['capital'][0] : 'No Capital',
      region: json['region'],
      flag: json['flags']['png'],
    );
  }

  static List<Country> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Country.fromJson(json)).toList();
  }
}
