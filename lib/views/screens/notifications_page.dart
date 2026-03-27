import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/notifications_page_controller.dart';
import 'package:smart_shopping_fe/core/class/no_data_card.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/data/model/notify_model.dart';
import 'package:smart_shopping_fe/views/widgets/notificationsPage/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsPageController());
    // A simple demo home
    return GetBuilder<NotificationsPageController>(builder: (controller) {
      return RefreshIndicator(
        onRefresh: () {
          return controller.onRefresh();
        },
        child: controller.notifications.isEmpty
            ? ListView(
                children: [
                  NoDataCard(text: Translate.noData.tr),
                ],
              )
            : ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) => NotificationCard(
                  notify: NotifyModel.fromJson(controller.notifications[index]),
                  onTap: () {
                    // controller.goToDetails(index);
                  },
                ),
              ),
      );
    });
  }
}
