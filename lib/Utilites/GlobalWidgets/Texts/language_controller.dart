  // // // // // import 'dart:convert';
  // // // // // import 'package:flutter/services.dart';
  // // // // //
  // // // // // class LanguageController {
  // // // // //   static Map<String, dynamic> _localizedStrings = {};
  // // // // //
  // // // // //   static Future<void> load(String langCode) async {
  // // // // //     String jsonString =
  // // // // //     await rootBundle.loadString('assets/languages/$langCode.json');
  // // // // //
  // // // // //     _localizedStrings = json.decode(jsonString);
  // // // // //   }
  // // // // //
  // // // // //   static String text(String key) {
  // // // // //     return _localizedStrings[key] ?? key;
  // // // // //   }
  // // // // // }
  // // // //
  // // // import 'dart:convert';
  // // //
  // // // import 'package:flutter/services.dart';
  // // //
  // // // class LanguageController {
  // // //   static Map<String, dynamic> _localizedStrings = {};
  // // //   static String currentLang = 'english';
  // // //
  // // //   static Future<void> load(String langCode) async {
  // // //     currentLang = langCode;
  // // //
  // // //     print("Current Lang::::$currentLang");
  // // //
  // // //     String jsonString =
  // // //     await rootBundle.loadString('assets/languages/$langCode.json');
  // // //
  // // //     _localizedStrings = json.decode(jsonString);
  // // //   }
  // // //
  // // //   static String text(String key) {
  // // //     return _localizedStrings[key] ?? key;
  // // //   }
  // // // }
  // // //
  // // // // import 'dart:convert';
  // // // // import 'package:flutter/material.dart';
  // // // // import 'package:flutter/services.dart';
  // // // //
  // // // // class AppLocalizations {
  // // // //   final Locale locale;
  // // // //
  // // // //   AppLocalizations(this.locale);
  // // // //
  // // // //   static AppLocalizations? of(BuildContext context) {
  // // // //     return Localizations.of<AppLocalizations>(context, AppLocalizations);
  // // // //   }
  // // // //
  // // // //   static const LocalizationsDelegate<AppLocalizations> delegate =
  // // // //   AppLocalizationsDelegate();
  // // // //
  // // // //   late Map<String, String> localizedStrings;
  // // // //
  // // // //   Future<bool> load() async {
  // // // //     String jsonString = await rootBundle.loadString(
  // // // //       'assets/languages/${locale.languageCode}.json',
  // // // //     );
  // // // //     Map<String, dynamic> jsonMap = json.decode(jsonString);
  // // // //
  // // // //     localizedStrings = jsonMap.map((key, value) {
  // // // //       return MapEntry(key, value.toString());
  // // // //     });
  // // // //
  // // // //     return true;
  // // // //   }
  // // // //
  // // // //   String translate(String key) {
  // // // //     return localizedStrings[key] ?? key;
  // // // //   }
  // // // // }
  // // // //
  // // // // class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // // // //   const AppLocalizationsDelegate();
  // // // //
  // // // //   @override
  // // // //   bool isSupported(Locale locale) {
  // // // //     return ['en', 'hi', 'gu'].contains(locale.languageCode);
  // // // //   }
  // // // //
  // // // //   @override
  // // // //   Future<AppLocalizations> load(Locale locale) async {
  // // // //     AppLocalizations localizations = AppLocalizations(locale);
  // // // //     await localizations.load();
  // // // //     return localizations;
  // // // //   }
  // // // //
  // // // //   @override
  // // // //   bool shouldReload(AppLocalizationsDelegate old) => false;
  // // // // }
  // // // //
  // //
  // // import 'dart:convert';
  // // import 'package:flutter/material.dart';
  // // import 'package:flutter/services.dart';
  // //
  // // class AppLocalizations {
  // //   final Locale locale;
  // //
  // //   AppLocalizations(this.locale);
  // //
  // //   static AppLocalizations? of(BuildContext context) {
  // //     return Localizations.of<AppLocalizations>(context, AppLocalizations);
  // //   }
  // //
  // //   static const LocalizationsDelegate<AppLocalizations> delegate =
  // //   AppLocalizationsDelegate();
  // //
  // //   late Map<String, String> localizedStrings;
  // //
  // //   Future<bool> load() async {
  // //     String jsonString = await rootBundle.loadString(
  // //       'assets/languages/${locale.languageCode}.json',
  // //     );
  // //     Map<String, dynamic> jsonMap = json.decode(jsonString);
  // //
  // //     localizedStrings = jsonMap.map((key, value) {
  // //       return MapEntry(key, value.toString());
  // //     });
  // //
  // //     return true;
  // //   }
  // //
  // //   String translate(String key) {
  // //     return localizedStrings[key] ?? key;
  // //   }
  // // }
  // //
  // // class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // //   const AppLocalizationsDelegate();
  // //
  // //   @override
  // //   bool isSupported(Locale locale) {
  // //     return ['en', 'hi', 'gu'].contains(locale.languageCode);
  // //   }
  // //
  // //   @override
  // //   Future<AppLocalizations> load(Locale locale) async {
  // //     AppLocalizations localizations = AppLocalizations(locale);
  // //     await localizations.load();
  // //     return localizations;
  // //   }
  // //
  // //   @override
  // //   bool shouldReload(AppLocalizationsDelegate old) => false;
  // // }
  //
  // import 'dart:convert';
  // import 'package:flutter/material.dart';
  // import 'package:flutter/services.dart';
  //
  // class AppLocalizations {
  //   final Locale locale;
  //
  //   AppLocalizations(this.locale);
  //
  //   static AppLocalizations? of(BuildContext context) {
  //     return Localizations.of<AppLocalizations>(context, AppLocalizations);
  //   }
  //
  //   late Map<String, String> _localizedStrings;
  //
  //   Future<void> load() async {
  //     String jsonString =
  //     await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
  //
  //     Map<String, dynamic> jsonMap = json.decode(jsonString);
  //
  //     _localizedStrings =
  //         jsonMap.map((key, value) => MapEntry(key, value.toString()));
  //   }
  //
  //   String translate(String key) {
  //     return _localizedStrings[key] ?? key;
  //   }
  // }
  //
  // class AppLocalizationsDelegate
  //     extends LocalizationsDelegate<AppLocalizations> {
  //   const AppLocalizationsDelegate();
  //
  //   @override
  //   bool isSupported(Locale locale) {
  //     return ['en', 'hi', 'gu'].contains(locale.languageCode);
  //   }
  //
  //   @override
  //   Future<AppLocalizations> load(Locale locale) async {
  //     AppLocalizations localizations = AppLocalizations(locale);
  //     await localizations.load();
  //     return localizations;
  //   }
  //
  //   @override
  //   bool shouldReload(covariant LocalizationsDelegate old) => false;
  // }

  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';

  class AppLocalizations {
    final Locale locale;

    AppLocalizations(this.locale);

    static AppLocalizations? of(BuildContext context) {
      return Localizations.of<AppLocalizations>(context, AppLocalizations);
    }

    static const LocalizationsDelegate<AppLocalizations> delegate =
    AppLocalizationsDelegate();

    late Map<String, String> localizedStrings;

    Future<bool> load() async {
      String jsonString = await rootBundle.loadString(
        'assets/languages/${locale.languageCode}.json',
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    }

    String translate(String key) {
      return localizedStrings[key] ?? key;
    }
  }

  class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
    const AppLocalizationsDelegate();

    @override
    bool isSupported(Locale locale) {
      return ['en', 'hi', 'gu'].contains(locale.languageCode);
    }

    @override
    Future<AppLocalizations> load(Locale locale) async {
      AppLocalizations localizations = AppLocalizations(locale);
      await localizations.load();
      return localizations;
    }

    @override
    bool shouldReload(AppLocalizationsDelegate old) => false;
  }
