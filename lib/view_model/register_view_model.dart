import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../data/dbhelper.dart';

class RegisterViewModel with ChangeNotifier {


  Future<List<User>> fetchUserFromDatabase() async {
    var dbHelper = DBHelper.db;
    Future<List<User>> user = dbHelper!.getUser();
    return user;
  }
}
