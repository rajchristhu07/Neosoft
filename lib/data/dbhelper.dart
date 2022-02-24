import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../model/user_model.dart';

class DBHelper {
  Database? _database;


  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }




  Future<Database> getDatabaseInstance() async {
    final directory = await getDatabasesPath();
    String path = join(directory, "user_table_data.db");

    //deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
      },
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, mobileno TEXT,emailId TEXT,password TEXT,gender TEXT,  picture TEXT,  address TEXT,  landmark TEXT,  city TEXT,  state TEXT,  pincode TEXT,  educational TEXT,  year TEXT,  grade TEXT,  exp TEXT,  desigination TEXT,  domain TEXT)");
      },
    );
  }

  Future<List<User>> getUser() async {
    var dbClient = await database;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM USER');
    List<User> user =  [];
    for (int i = 0; i < list.length; i++) {
      user.add(User(list[i]["firstname"], list[i]["lastname"], list[i]["mobileno"], list[i]["emailId"],list[i]["password"],list[i]["gender"], list[i]["picture"], list[i]["address"], list[i]["landmark"], list[i]["city"], list[i]["state"], list[i]["pincode"], list[i]["educational"], list[i]["year"], list[i]["grade"], list[i]["exp"], list[i]["desigination"], list[i]["domain"]));
    }
    return user;
  }
}