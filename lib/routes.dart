import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smart_shopping_fe/core/constants/app_routes_names.dart';
import 'package:smart_shopping_fe/views/screens/market_page.dart';
import 'package:smart_shopping_fe/views/screens/favorites_page.dart';
import 'package:smart_shopping_fe/views/screens/offer_details_page.dart';

import 'core/shared/splash_screen.dart';
import 'core/modules/main_screen.dart';

List<GetPage<dynamic>>? routesPages = [
  GetPage(
    name: AppRoutes.splash,
    page: () => SplashScreen(),
    // binding: MyBinding(), // ✅ Bind splash dependencies
  ),
  GetPage(name: AppRoutes.start, page: () => const MainScreen()),
  GetPage(name: AppRoutes.homePage, page: () => const MainScreen()),
  GetPage(
      name: AppRoutes.offerDetailsPage, page: () => const OfferDetailsPage()),
  GetPage(name: AppRoutes.favoritesPage, page: () => const FavoritesPage()),
  GetPage(name: AppRoutes.marketPage, page: () => const MarketPage()),
];
