import 'package:flutter/foundation.dart';
import 'package:neosoft/view_model/register_repo.dart';

import '../model/user_model.dart';


class RegisterViewModel with ChangeNotifier {
  RegisterRepo repository;

  RegisterViewModel(this.repository);

  Future<List<User>> getAllUsers() async {
    final dogs = await repository.fetchUserFromDatabase();
    return dogs;
  }
  Future addUser(User user) async {
      await repository.saveUser(user);
    notifyListeners();
  }

}
