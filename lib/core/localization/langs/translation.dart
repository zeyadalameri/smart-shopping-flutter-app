import 'package:get/get.dart';
import 'ar_AR.dart';
import 'en_us.dart';

class MyLocales extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar_AR": ArAr.message,
        "en_US": EnUs.message,
      };
}

class Translate {
  // static String appName = 'appName';
  static String warning = 'warning';
  static String warning1 = 'warning1';
  static String alertexitingApp = 'alertexitingApp';
  static String yes = 'yes';
  static String cancel = 'cancel';
  static String noTitle = 'noTitle';
  static String homePage = 'homePage';
  static String notificationPage = 'notificationPage';
  static String favoritesPage = 'favoritesPage';
  static String termsAndConditions = 'termsAndConditions';
  static String privacyPolicy = 'privacyPolicy';
  static String invitefriend = 'invitefriend';
  static String all = 'all';
  static String nearest = 'nearest';
  static String distance = 'distance';
  static String noLocation = 'noLocation';
  static String errorImage = 'errorImage';
  static String inActive = 'inActive';
  static String active = 'active';
  static String address = 'address';
  static String price = 'price';
  static String discount = 'discount';
  static String category = 'category';
  static String store = 'store';
  static String status = 'status';
  static String removeFavorite = 'removeFavorite';
  static String addFavorite = 'addFavorite';
  static String goToMap = 'goToMap';
  static String priceAfterDiscount = 'priceAfterDiscount';
  static String noData = 'noData';
  static String offers = 'offers';
  static String markets = 'markets';
  static String confirm = "confirm";
}
