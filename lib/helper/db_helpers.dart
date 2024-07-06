// import 'dart:developer';
//
// import 'package:sqflite/sqflite.dart';
//
// import '../model/todo_model.dart';
// import 'package:path/path.dart';
//
// mixin Todos {
//   Future<void> initDB();
//   Future<int> insertMyTask({required String title});
//   Future<List<TodoModel>> getMyTasks();
//   void searchMyTasks({required String title});
// }
//
// class DBHelper with Todos {
//   DBHelper._();
//
//   static DBHelper dbHelper = DBHelper._();
//
//   Database? db;
//   String tableName = "TODO";
//   String tableId = "id";
//   String tableTitle = "title";
//
//   @override
//   Future<void> initDB() async {
//     String dbLocation = await getDatabasesPath();
//     String path = join(dbLocation, "Todo.db");
//
//     db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, _) async {
//         String query =
//             "CREATE TABLE $tableName($tableId INTEGER PRIMARY KEY AUTOINCREMENT, $tableTitle TEXT NOT NULL);";
//         await db.execute(query).then((value) {
//           log("$tableName table Created Successfully 😎");
//         }).onError((error, _) {
//           log("ERROR : $error");
//         });
//       },
//     );
//   }
//
//   @override
//   Future<int> insertMyTask({required String title}) async {
//     await initDB();
//
//     // String query = "INSERT INTO $tableName ($tableTitle) VALUES(?)";
//     // List args = [title];
//     // return await db!.rawInsert(query, args);
//
//     Map<String, dynamic> data = {
//       tableTitle: title,
//     };
//
//     return await db!.insert(
//       tableName,
//       data,
//     );
//   }
//
//   @override
//   Future<List<TodoModel>> getMyTasks() async {
//     await initDB();
//     String query = "SELECT * FROM $tableName;";
//
//     List<Map<String, dynamic>> data = await db!.rawQuery(query);
//
//     return data.map((e) => TodoModel.fromMap(data: e)).toList();
//   }
//
//   @override
//   Future<List<TodoModel>> searchMyTasks({required String title}) async {
//     await initDB();
//     String query = "SELECT * FROM $tableName WHERE $tableTitle LIKE '%$title%'";
//
//     List<Map<String, dynamic>> data = await db!.rawQuery(query);
//     return data.map((e) => TodoModel.fromMap(data: e)).toList();
//   }
// }

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
