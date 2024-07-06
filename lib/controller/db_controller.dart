import 'package:ad_flutter_exam/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../helper/db_helpers.dart';

class DbController extends ChangeNotifier {
  List<Country> likedcountry = [];

  Logger logger = Logger();

  DbController() {
    initData();
  }

  Future<void> initData() async {
    DbHelper.dbHelper.initDb();
    likedcountry = await DbHelper.dbHelper.getAllData();
    notifyListeners();
  }

  void insertData({required Country country, required String image}) {
    DbHelper.dbHelper.insertData(country: country, image: image);
    logger.i(likedcountry);
    initData();
  }
}
