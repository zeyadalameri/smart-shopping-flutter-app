import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/constants/app_routes_names.dart';
import 'package:smart_shopping_fe/core/localization/controller/locale_controller.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/core/services/location/location_service.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'package:smart_shopping_fe/views/screens/home_page.dart';
import 'package:smart_shopping_fe/views/screens/notifications_page.dart';

abstract class MainScreenControllerImp extends GetxController {
  changePage(int index);
}

class MainscreenController extends MainScreenControllerImp {
  final LocationService locationService = Get.find<LocationService>();

  LcaleController localeController = Get.put(LcaleController());
  int currentpage = 0;

  List bottomappbar = [
    {
      "page": const HomePage(),
      "title": Translate.homePage,
      "icon": Icons.home_outlined
    },
    {
      "page": const NotificationsPage(),
      "title": Translate.notificationPage,
      "icon": Icons.notifications_active_outlined
    },
  ];
  List drower = [];
  @override
  void onInit() {
    drower = [
      {
        "title": Translate.favoritesPage,
        "Active_icon": Icons.favorite_outline,
        "icon": Icons.favorite_outline,
        "onTap": () async {
          Get.toNamed(AppRoutes.favoritesPage);
        },
      },
      {
        "title": Translate.termsAndConditions,
        "Active_icon": Icons.book_rounded,
        "icon": Icons.book_outlined,
        "onTap": () async {
          //
        },
      },
      {
        "title": Translate.privacyPolicy,
        "Active_icon": Icons.policy,
        "icon": Icons.policy_outlined,
        "onTap": () async {
          //
        },
      },
      {
        "title": Translate.invitefriend,
        "Active_icon": Icons.share,
        "icon": Icons.share_outlined,
        "onTap": () async {
          Get.bottomSheet(Container(
            color: Get.theme.scaffoldBackgroundColor,
            height: 200,
          ));
        },
      },
    ];
    // locationService.stop();
    locationService.start();
    // flutterBackgroundService.on('position').listen(
    //   (event) {
    //     if (event!['position'] != null) {}
    //   },
    // );

    // .invoke("position", {
    //   "lat": position.latitude,
    //   "long": position.longitude,
    // });
    //  distanceCm = await callbackLocationData.getDistance(position) / 100;
    super.onInit();
  }

  MyServices myServices = Get.find();

  @override
  changePage(int index) {
    currentpage = index;
    update();
  }
}
