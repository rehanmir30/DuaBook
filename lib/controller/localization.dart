import 'dart:ui';

import 'package:get/get.dart';
import 'package:duabook/constants/translations.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => AppTranslations.translations;

// List of supported locales
  static final locales = [
    Locale('English', 'US'),
    Locale('French', 'FR'),
    Locale('German', 'DE'),
    Locale('Indonesian', 'ID'),
    Locale('Japanese', 'JP'),
    Locale('Malay', 'MY'),
    Locale('Mandarin', 'CN'),
    Locale('Portuguese', 'PT'),
    Locale('Russian', 'RU'),
    Locale('Spanish', 'ES'),
    Locale('Turkish', 'TR'),
    Locale('Bengali', 'BD'),
    Locale('Urdu', 'PK'),
    Locale('Arabic', 'SA'),
    Locale('Hindi', 'IN'),
    Locale('Marathi', 'IN'),
    Locale('Telugu', 'IN'),
    Locale('Gujarati', 'IN'),
    Locale('Tamil', 'IN'),
    Locale('Punjabi', 'PK')
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