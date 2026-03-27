import 'package:smart_shopping_fe/core/constants/app_fonts_assets.dart';
import 'package:smart_shopping_fe/core/localization/theme/dark_theme.dart';
import 'package:smart_shopping_fe/core/localization/theme/light_theme.dart';
import '/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 📌 وصف الملف
///
/// [LcaleController]
///
/// هوالمسؤول عن إدارة إعدادات اللغة والثيم في التطبيق
///
/// [Locale] يتم التحكم في اللغة من خلال الـ ،
///
/// [SharedPreferences] ويتم تحديد الثيم (داكن أو فاتح) بناءً على تفضيلات المستخدم المخزنة في
///

class LcaleController extends GetxController {
  Locale? language = Locale('en', 'US');

  final List appLanguages = [
    {'name': 'العربية', 'locale': const Locale('ar', 'AR')},
    {'name': 'English', 'locale': const Locale('en', 'US')},
  ];
  final Map dirctions = {
    "ar": TextDirection.rtl,
    "en": TextDirection.ltr,
  };
  final Map fonts = {
    "ar": AppFontsAssets.cairo,
    "en": AppFontsAssets.cairo,
  };
  bool isDark = false;
  MyServices myServices = Get.find();

  List<GetPage<dynamic>> routePages = [
    // route
  ];

  changeLocale(Locale locale) {
    language = locale;
    myServices.sharedPreferences
        .setString('lang', '${locale.languageCode}_${locale.countryCode}');
    Get.updateLocale(locale);
    update();
  }

  translate(String text) {
    return Get
        .translations[language!.toLanguageTag().replaceAll('-', '_')]![text];
  }

  changeTheme() {
    isDark = !isDark;
    myServices.sharedPreferences.setBool('isDark', isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  getTheme() {
    String localeText = getTextLocale();
    return isDark
        ? DarkTheme.get(fonts[localeText])
        : LightTheme.get(fonts[localeText]);
  }

  getTextLocale() {
    Locale locale = language ?? Locale('en', 'US');
    String localeText = locale.languageCode;
    return localeText;
  }

  bool isAppInForeground = true; // Track if app is in foreground

  @override
  void onInit() {
    // createNotificationChannel();

    String? sharedPrefLang = myServices.sharedPreferences.getString('lang');
    isDark = myServices.sharedPreferences.getBool('isDark') ?? false;
    if (sharedPrefLang == null) {
      List langs = appLanguages.map((e) => e['locale']).toList();
      language = langs.contains(Get.deviceLocale)
          ? Get.deviceLocale
          : const Locale('en', 'US');
    } else {
      language =
          Locale(sharedPrefLang.split('_')[0], sharedPrefLang.split('_')[1]);
    }

    super.onInit();
  }

  getDirection() {
    return dirctions[getTextLocale()];
  }
}
