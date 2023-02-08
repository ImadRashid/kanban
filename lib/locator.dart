import 'package:get_it/get_it.dart';

import 'core/services/auth_services.dart';
import 'core/services/database_services.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton<AuthService>(AuthService());
}
