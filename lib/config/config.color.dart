import 'package:flutter/material.dart';

abstract class IColors {
  static const neutral10 = Color(0xFF1B1B1F);
  static const neutral20 = Color(0xFF313034);
  static const neutral30 = Color(0xFF47464A);
  static const neutral50 = Color(0xFF78767A);
  static const neutral60 = Color(0xFF929094);
  static const neutral70 = Color(0xFFADAAAF);
  static const neutral90 = Color(0xFFE5E1E6);
  static const neutral95 = Color(0xFFF3EFF4);
  static const neutral99 = Color(0xFFFFFBFF);

  static const secondary40 = Color(0xFFC00013);
  static const secondary50 = Color(0xFFEB1921);
  static const secondary50_ = Color.fromARGB(55, 235, 25, 32);
  static const secondary95 = Color(0xFFFFEDEA);

  static const black5 = Color(0xFFEFEFF3);
  static const black01 = Color(0xFFF7F7FA);
  static const black10 = Color(0xFFE8E8E8);
  static const black40 = Color(0xFFCACCCF);
  static const black60 = Color(0xFFA0A4A8);
  static const black80 = Color(0xFF52575C);
  static const black100 = Color(0xFF25282B);
  static const blacktransparant = Color.fromARGB(138, 0, 0, 0);
  static const whitetransparant = Color.fromARGB(207, 255, 255, 255);

  static const green50 = Color(0xFFE7FAF1);
  static const green100 = Color(0xFFCDF4E3);
  static const green200 = Color(0xFF9CE9C7);
  static const green300 = Color(0xFF6ADFAA);
  static const green400 = Color(0xFF39D48E);
  static const green500 = Color(0xFF07C972);
  static const green600 = Color(0xFF059756);
  static const green700 = Color(0xFF046539);
  static const green800 = Color(0xFF08170F);
  static const green900 = Color(0xFF01140B);

  static const gray50 = Color(0xFFF2F2F2);
  static const gray100 = Color(0xFFE3E3E3);
  static const gray200 = Color(0xFFC8C8C8);
  static const gray300 = Color(0xFFACACAC);
  static const gray400 = Color(0xFF919191);
  static const gray500 = Color(0xFF757575);
  static const gray600 = Color(0xFF585858);
  static const gray700 = Color(0xFF3B3B3B);
  static const gray800 = Color(0xFF1D1D1D);
  static const gray900 = Color(0xFF0C0C0C);

  static const orange60 = Color(0xFFFD7946);
  static const orange70 = Color(0xFFF85A1D);

  static const pink50 = Color(0xFFE25D5D);
  static const pink50_ = Color(0xFFFFE0E0);
  static const pinkBackground = Color(0xFFFFF9F5);

  static const red50 = Color(0xFFF44336);
  static const backgroundLogin = Color(0xFFE9EFEC);
}

var colorGreen = MaterialColor(
  IColors.green500.value,
  <int, Color>{
    50: const Color(0xFFE7FAF1),
    100: const Color(0xFFCDF4E3),
    200: const Color(0xFF9CE9C7),
    300: const Color(0xFF6ADFAA),
    400: const Color(0xFF39D48E),
    500: Color(IColors.green500.value),
    600: const Color(0xFF059756),
    700: const Color(0xFF046539),
    800: const Color(0xFF02321D),
    900: const Color(0xFF01140B),
  },
);

var lightColorScheme = ColorScheme.fromSwatch(
  primarySwatch: colorGreen,
  brightness: Brightness.light,
);

var darkColorScheme = ColorScheme.fromSwatch(
  primarySwatch: colorGreen,
  brightness: Brightness.dark,
);
