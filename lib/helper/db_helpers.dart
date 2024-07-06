
import 'package:ad_flutter_exam/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

enum likedcountry { name, capital, region, flags }

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Logger logger = Logger();
  String sql = '';
  String dbName = "my_dataBase";
  String tableName = "likedcountry";

  late Database database;

  Future<void> initDb() async {
    String path = await getDatabasesPath();

    database = await openDatabase("$path/$tableName", version: 3,
        onCreate: (db, version) {
      String query =
          """create table if not exists $tableName (${likedcountry.name.name} ,
                          ${likedcountry.capital.name} text not null,
                          ${likedcountry.region.name} text
                          ${likedcountry.flags.name} text
                          )""";

      db
          .execute(query)
          .then(
            (value) => logger.i("Table Create successfully"),
          )
          .onError(
            (error, stackTrace) => logger.e("ERROR : $error"),
          );
    }, onUpgrade: (db, v1, v2) {
      sql = "alter table $tableName add column category text";
      db
          .execute(sql)
          .then((value) => logger.i('alter category added'))
          .onError((error, stackTrace) => logger.e('error : $error'));
    });
  }

  Future<void> insertData({required Country country, required image}) async {
    sql =
        "insert into $tableName(name, capital, region, flags) values(?,?,?,?,?);";
    List args = [
      country.name,
      country.capital,
      country.region,
      country.flag,
      image
    ];
    await database.rawInsert(sql, args);
  }

  Future<List<Country>> getAllData() async {
    List<Country> allLikeData = [];

    sql = "select * from $tableName;";
    List Data = await database.rawQuery(sql);
    allLikeData = Data.map((e) => Country.fromJson(e)).toList();

    return allLikeData;
  }
}
