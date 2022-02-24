import 'package:get_it/get_it.dart';

import '../data/dbhelper.dart';
import '../view_model/register_repo.dart';

GetIt serviceLocater = GetIt.instance;

Future<void> init() async {
  serviceLocater.registerSingleton<DBHelper>(DBHelper());
  serviceLocater.registerSingleton<RegisterRepo>(RegisterRepo(serviceLocater()));
}