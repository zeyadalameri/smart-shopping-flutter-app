import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/notifications_page_controller.dart';
import 'package:smart_shopping_fe/core/class/local_transaction.dart';
import 'package:smart_shopping_fe/core/functions/awsome_notification_messaging.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'package:smart_shopping_fe/data/model/notify_model.dart';

/// 📌 وصف الملف
///
/// [setupFirebaseMessaging]
///
/// Firebase Cloud Messaging (FCM) هي دالة تقوم بتهيئة
///
///لاستقبال الإشعارات الفورية
///
///
/// 📌 وظيفة الكود
///
/// 🔹 `setupFirebaseMessaging()`: [subscribeToTopic] والاشتراك في   Firebase Messaging تقوم بإعداد
///
///    تحت [all_users] والحصول على رمز الجهاز مثلا  تم الاشتراك في
///
/// 🔹 `FirebaseMessaging.onMessage.listen(...)`: تستمع للإشعارات الواردة عندما يكون التطبيق في المقدمة.
///
/// 🔹 `FirebaseMessaging.onBackgroundMessage(backgroundHandler)`: تعالج الإشعارات عندما يكون التطبيق في الخلفية أو مغلقًا.
///
/// 🔹 `backgroundHandler(RemoteMessage message)`: تعالج الإشعارات في الخلفية، وتضيفها إلى قائمة الإشعارات المخزنة.
///
/// 🔹 `showForegroundNotification(...)`: تعرض إشعارًا للمستخدم عند وصول إشعار جديد أثناء استخدام التطبيق.
///
///
/// 📌 المخرجات المحتملة
///
/// ✅عند تشغيل التطبيق أو في الخلفية Firebase استقبال إشعارات
///
/// ✅[sharedPrefrence] تخزين الإشعارات داخل .
///
/// ✅ عرض إشعارات محلية عند استقبال إشعارات جديدة.
///
/// ✅ التعامل مع إشعارات الخلفية والمقدمة بكفاءة.
///
/// 🚀 هذا الكود يضمن استلام الإشعارات الفورية وإدارتها بسلاسة داخل التطبيق! 🚀

Future<void> setupFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  debugPrint('============FirebaseMessaging ok==================');
  await messaging.getToken().then(
    (value) {
      debugPrint('=============this is your device token=================');
      debugPrint(value);
      debugPrint('==============================');
    },
  );

  // For handling background and terminated state messages
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // Get the initial message if the app was opened from a notification
  RemoteMessage? initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    // Handle the notification
  }

  // Foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "Message received: ${message.notification!.title!} , ${message.notification!.body!}");
    NotificationsPageController controller =
        Get.put(NotificationsPageController());
    var random = Random(); // إنشاء كائن Random
    int randomNumber = random.nextInt(1000000); // رقم عشوائي بين 0 و99
    controller.addToNotifications(NotifyModel(
      id: "firebase_$randomNumber",
      title: message.notification!.title,
      description: message.notification!.body,
    ));

    showForegroundNotification(randomNumber, message.notification!.title!,
        message.notification!.body!, NotificationLayout.Default);
  });

  try {
    await FirebaseMessaging.instance.subscribeToTopic("all_users");
  } catch (e) {
    debugPrint('========cant subscripe to topic ======================');
  }
  // initialServices();
}

Future<void> backgroundHandler(RemoteMessage message) async {
  // Handle background notifications here

  try {
    await Get.putAsync(() => MyServices().init());
    Get.put(LocalTransaction());
    debugPrint("Background message: ${message.data}");
    NotificationsPageController controller =
        Get.put(NotificationsPageController());

    var random = Random(); // إنشاء كائن Random
    int randomNumber = random.nextInt(1000000); // رقم عشوائي بين 0 و99

    controller.addToNotifications(NotifyModel(
      id: "firebase_$randomNumber",
      title: message.notification!.title,
      description: message.notification!.body,
    ));
  } catch (e) {
    debugPrint("Background error: ${e}");
  }
}
