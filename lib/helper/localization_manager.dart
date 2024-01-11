import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/game_routes.dart';

class LocalizationManager {
  static const String _path = 'assets/translations';
  static const List<Locale> _supportedLocales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
  ];

  static String get path => _path;
  static List<Locale> get supportedLocales => _supportedLocales;
  static Locale get fallbackLocale => _supportedLocales.first;

  static Locale get currentLocale =>
      EasyLocalization.of(GameRoutes.navigatorKey.currentContext!)!.locale;
  static String get currentLanguageName => currentLocale.languageCode == 'en'
      ? 'English'
      : currentLocale.languageCode == 'tr'
          ? 'Türkçe'
          : 'Unknown';

  void changeLocale(BuildContext context, Locale locale) {
    context.setLocale(locale);
  }
}
