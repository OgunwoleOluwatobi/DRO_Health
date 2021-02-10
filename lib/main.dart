
import 'package:dro_test/app/locator.dart';
import 'package:dro_test/app/router.dart';
import 'package:dro_test/core/constants/setup_dialog.dart';
import 'package:dro_test/core/utils/logger.dart';
import 'package:dro_test/ui/theme/theme.dart';
import 'package:dro_test/ui/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light
    )
  );
  setupLogger();
  await setupLocator();
  setupDialog();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DRO Health',
      theme: lightTheme,
      onGenerateRoute: Routers().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      home: MainView(),
    );
  }
}