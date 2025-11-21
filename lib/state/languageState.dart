import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageState extends ChangeNotifier {
  Locale _locale = const Locale('en', '');
  
  Locale get locale => _locale;
  
  bool get isArabic => _locale.languageCode == 'ar';
  bool get isEnglish => _locale.languageCode == 'en';

  LanguageState() {
    _loadLanguage();
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language_code') ?? 'en';
    _locale = Locale(languageCode, '');
    notifyListeners();
  }

  void changeLanguage(String languageCode) async {
    if (_locale.languageCode != languageCode) {
      _locale = Locale(languageCode, '');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', languageCode);
      notifyListeners();
    }
  }

  void toggleLanguage() {
    String newLanguageCode = _locale.languageCode == 'en' ? 'ar' : 'en';
    changeLanguage(newLanguageCode);
  }
}