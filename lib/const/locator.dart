
import '../repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../services/auth_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => AuthService());

}