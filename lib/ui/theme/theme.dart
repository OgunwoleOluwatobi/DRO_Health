import 'package:dro_test/ui/styles/brand_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: createMaterialColor(BrandColors.darkPurple),
  primaryColor: BrandColors.darkPurple,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textSelectionColor: BrandColors.droPurple,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    elevation: 0,
    brightness: Brightness.light,
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    headline3: TextStyle().copyWith(color: Colors.black,),
    headline4: TextStyle().copyWith(color: Colors.black,),
    headline5: TextStyle().copyWith(color: Colors.black,),
    headline6: TextStyle().copyWith(color: Colors.black,)
  ),
  primaryTextTheme: TextTheme(
    headline6: TextStyle().copyWith(color: Colors.black, fontWeight: FontWeight.w600,)
  ),
  iconTheme: IconThemeData(
    color: Colors.black
  ),
  fontFamily: 'Proxima Nova',
  dividerColor: Colors.black12,
  cardColor: Colors.white54
  // accentColor: Colors.black,
  // accentIconTheme: IconThemeData(color: Colors.white),
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}