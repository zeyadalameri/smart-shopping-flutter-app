import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/modules/mainscreen_controller.dart';
import 'package:smart_shopping_fe/controllers/notifications_page_controller.dart';
import 'package:smart_shopping_fe/core/functions/alert_exit_app.dart';
import 'package:smart_shopping_fe/core/modules/mainScreen/bottom_nav_bar.dart';
import 'package:smart_shopping_fe/core/modules/mainScreen/custom_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainscreenController());
    Get.put(NotificationsPageController());
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => alertExitApp(),
      child: GetBuilder<MainscreenController>(
          builder: (controller) => Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  appBar: AppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      title: Text(
                          "${controller.bottomappbar.elementAt(controller.currentpage)['title']}"
                              .tr,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                      centerTitle: true,
                      actions: [
                        // SizedBox(width: 10),
                      ]),
                  drawer: const CustomDrawer(),
                  bottomNavigationBar: const BottomNavBar(),
                  body: Directionality(
                      textDirection: controller.localeController.getDirection(),
                      child: controller.bottomappbar
                          .elementAt(controller.currentpage)['page']),
                ),
              )),
    );
  }
}
