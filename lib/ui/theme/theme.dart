import 'package:flutter/material.dart';
part 'app_icons.dart';
part 'color/light_color.dart';
part 'text_styles.dart';
part 'extention.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: TwitterColor.white,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    cardColor: Colors.white,
    unselectedWidgetColor: Colors.grey,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: TwitterColor.white,
      iconTheme: IconThemeData(
        color: TwitterColor.dodgeBlue,
      ),
      elevation: 0,
      // ignore: deprecated_member_use
    ),
    bottomAppBarTheme: ThemeData.light().bottomAppBarTheme.copyWith(
          color: Colors.white,
          elevation: 0,
        ),
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(color: TwitterColor.dodgeBlue),
      unselectedLabelColor: AppColor.darkGrey,
      unselectedLabelStyle: const TextStyle(color: AppColor.darkGrey),
      labelColor: TwitterColor.dodgeBlue,
      labelPadding: const EdgeInsets.symmetric(vertical: 12),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: TwitterColor.dodgeBlue,
    ),
    colorScheme: const ColorScheme(
      background: Colors.white,
      onPrimary: Colors.white,
      onBackground: Colors.black,
      onError: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      primary: Colors.blue,
      primaryContainer: Colors.blue,
      secondary: AppColor.secondary,
      secondaryContainer: AppColor.darkGrey,
      surface: Colors.white,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF15202B),
    brightness: Brightness.dark,
    primaryColor: TwitterColor.dodgeBlue,
    cardColor: const Color(0xFF1E2732),
    unselectedWidgetColor: Colors.grey,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E2732),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF15202B),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
    ),
    bottomAppBarTheme: ThemeData.dark().bottomAppBarTheme.copyWith(
          color: const Color(0xFF1E2732),
          elevation: 0,
        ),
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(color: TwitterColor.dodgeBlue),
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      labelColor: TwitterColor.dodgeBlue,
      labelPadding: const EdgeInsets.symmetric(vertical: 12),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: TwitterColor.dodgeBlue,
    ),
    colorScheme: const ColorScheme(
      background: Color(0xFF15202B),
      onPrimary: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      error: Colors.red,
      primary: Colors.blue,
      primaryContainer: Colors.blue,
      secondary: Color(0xFF8899A6),
      secondaryContainer: Color(0xFF8899A6),
      surface: Color(0xFF1E2732),
      brightness: Brightness.dark,
    ),
  );

  // Backward compatibility
  static ThemeData get appTheme => lightTheme;

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(
        blurRadius: 10,
        offset: const Offset(5, 5),
        color: AppTheme.appTheme.colorScheme.secondary,
        spreadRadius: 1)
  ];
  static BoxDecoration softDecoration =
      const BoxDecoration(boxShadow: <BoxShadow>[
    BoxShadow(
        blurRadius: 8,
        offset: Offset(5, 5),
        color: Color(0xffe2e5ed),
        spreadRadius: 5),
    BoxShadow(
        blurRadius: 8,
        offset: Offset(-5, -5),
        color: Color(0xffffffff),
        spreadRadius: 5)
  ], color: Color(0xfff1f3f6));
}

String get description {
  return '';
}
