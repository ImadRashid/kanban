import 'package:get_it/get_it.dart';
import 'package:karbanboard/core/services/internet_connectivity_service.dart';

import 'core/services/auth_services.dart';
import 'core/services/database_services.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton(InternetConnectivityService());
}
