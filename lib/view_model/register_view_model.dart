import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../utility/dbhelper.dart';

class RegisterViewModel with ChangeNotifier {


  Future<List<User>> fetchUserFromDatabase() async {
    var dbHelper = DBHelper.instance;
    Future<List<User>> user = dbHelper.getUser();
    return user;
  }
}
