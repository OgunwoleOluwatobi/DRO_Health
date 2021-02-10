import 'package:dro_test/core/services/main_service.dart';
import 'package:dro_test/core/utils/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator({bool test = false})async {
  locator.registerLazySingleton<NavigationService>(
    () => NavigationService()
  );
  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );
  locator.registerLazySingleton<SnackbarService>(
    () => SnackbarService(),
  );
  locator.registerLazySingleton<MainService>(
    () => MainService(),
  );

  Logger.d('Initialization Done...');
}