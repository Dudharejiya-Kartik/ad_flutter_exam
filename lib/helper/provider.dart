import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:http/http.dart' as http;

class CountryProvider with ChangeNotifier {
  CountryProvider() {
    fetchCountries();
  }
  List<Country> _countries = [];
  List<Country> _savedCountries = [];

  List<Country> get countries => _countries;
  List<Country> get savedCountries => _savedCountries;

  Future<void> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all?_gl=1'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      _countries = Country.fromJsonList(jsonList);
      notifyListeners();
      print(_countries.length);
    } else {
      throw Exception('Failed to load countries');
    }
  }

  void saveCountry(Country country) {
    _savedCountries.add(country);
    notifyListeners();
  }
}
