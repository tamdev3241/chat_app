import 'package:chat_app/until/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFontWeight {
  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const ultraBold = FontWeight.w900;
}

class AppTheme {
  /// light theme
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: AppColors.lightThemeColor,
    primaryColor: AppColors.primaryColor,
    highlightColor: AppColors.primaryColor.withOpacity(0.2),
    hintColor: AppColors.subLightColor,
    scaffoldBackgroundColor: AppColors.lightThemeColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    indicatorColor: AppColors.lightThemeColor,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: AppFontWeight.bold,
        color: AppColors.darkThemeColor,
      ),
      headline2: TextStyle(
        fontSize: 25,
        fontWeight: AppFontWeight.bold,
        color: AppColors.darkThemeColor,
      ),
      headline3: TextStyle(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
        color: AppColors.darkThemeColor,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: AppFontWeight.bold,
        color: AppColors.darkThemeColor,
      ),
      headline5: TextStyle(
        fontSize: 18,
        fontWeight: AppFontWeight.bold,
        color: AppColors.darkThemeColor,
      ),
      headline6: TextStyle(
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
        color: AppColors.darkThemeColor,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
        fontWeight: AppFontWeight.medium,
        color: AppColors.darkThemeColor,
      ),
      bodyText2: TextStyle(
        fontSize: 15,
        fontWeight: AppFontWeight.regular,
        color: AppColors.subLightColor,
      ),
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
        color: AppColors.darkThemeColor,
      ),
      subtitle2: TextStyle(
        fontSize: 13,
        fontWeight: AppFontWeight.regular,
        color: AppColors.subLightColor,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.lightThemeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkThemeColor,
      size: 24.0,
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: AppColors.subLightColor,
    ),
  );
}
