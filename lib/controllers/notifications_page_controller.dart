// lib/core/controllers/neer_markets_page_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/functions/show_undo_snack_bar.dart';
import 'package:smart_shopping_fe/data/model/notify_model.dart';
import 'package:smart_shopping_fe/data/storage/notifications_page_storage.dart';

abstract class NotificationsPageControllerImp extends GetxController {
  removeFromNotifications(NotifyModel notifyModel);
  addToNotifications(NotifyModel notify);
  checkIfStored(String id);
  loadFromStorage();
}

class NotificationsPageController extends NotificationsPageControllerImp {
  List<Map<String, dynamic>> notifications = [];

  static const String _notificationKey = "notifications";
  NotificationsPageStorage notificationsPageStorage =
      NotificationsPageStorage(Get.find());
  @override
  void onInit() {
    super.onInit();

    loadFromStorage();
  }

  @override
  addToNotifications(NotifyModel notify) {
    try {
      notifications.add(notify.toJson());
      notificationsPageStorage.setData(_notificationKey, notifications);
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(title: "اشعار", messageText: const Text("هناك مشكلة"));
    }
    update();
  }

  @override
  removeFromNotifications(NotifyModel notifyModel) async {
    Map<String, dynamic> notify = notifyModel.toJson();
    notifications.removeWhere((element) => element['id'] == notify['id']);
    try {
      notificationsPageStorage.setData(_notificationKey, notifications);
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      showUndoSnackbar(
        contentText: "تم حذف المنتج من المفضلة",
        afterExecuteMethod: () {
          notifications.add(notify);
          update();

          notificationsPageStorage.setData(_notificationKey, notifications);
        },
      );
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(title: "اشعار", messageText: const Text("هناك مشكلة"));
    }
    update();
  }

  @override
  checkIfStored(String id) {
    return (notifications.where((element) => element['id'] == id).isNotEmpty);
  }

  @override
  loadFromStorage() {
    try {
      var data = notificationsPageStorage.getData(_notificationKey);
      if (data.isNotEmpty) {
        // Assign stored offers
        notifications.clear();
        notifications.addAll(List<Map<String, dynamic>>.from(data));
      }
    } catch (e) {
//
    }
    update();
  }

  Future<void> onRefresh() async {
    loadFromStorage();

    return;
  }
}
