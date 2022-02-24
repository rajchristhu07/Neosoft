import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../data/dbhelper.dart';

class RegisterRepo with ChangeNotifier {
  DBHelper database;
  RegisterRepo(this.database);

  Future<List<User>> fetchUserFromDatabase() async {
    var dbHelper = database.getUser();
    Future<List<User>> user = dbHelper;
    return user;
  }
  Future<User> getUserById(int id) async {
    final users = await database.getUser();
    return users.firstWhere((d) => d.id == id);
  }

  Future<User> saveUser(User user) async {
    var dbClient = await database.database;
    await dbClient!.insert("USER", user.toMap());
    return user;
  }

}
