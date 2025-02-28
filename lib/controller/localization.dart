import 'dart:ui';

import 'package:get/get.dart';
import 'package:duabook/constants/translations.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => AppTranslations.translations;

// List of supported locales
  static final locales = [
    Locale('english', 'US'),
    Locale('french', 'FR'),
    Locale('german', 'DE'),
    Locale('indonesian', 'ID'),
    Locale('japanese', 'JP'),
    Locale('malay', 'MY'),
    Locale('mandarin', 'CN'),
    Locale('portuguese', 'PT'),
    Locale('russian', 'RU'),
    Locale('spanish', 'ES'),
    Locale('turkish', 'TR'),
    Locale('bengali', 'BD'),
    Locale('urdu', 'PK'),
    Locale('arabic', 'SA'),
    Locale('hindi', 'IN'),
    Locale('marathi', 'IN'),
    Locale('telugu', 'IN'),
    Locale('gujarati', 'IN'),
    Locale('tamil', 'IN'),
    Locale('punjabi', 'PK')
  ];

  // Function to change the locale
  static void changeLocale(String languageCode) {
    final locale = getLocaleFromLanguageCode(languageCode);
    if (locale != null) {

      Get.updateLocale(locale);
    }
  }

  // Helper function to fetch Locale from language code
  static Locale? getLocaleFromLanguageCode(String languageCode) {
    for (Locale locale in locales) {
      if (locale.languageCode == languageCode) {
        return locale;
      }
    }
    return null;
  }
}