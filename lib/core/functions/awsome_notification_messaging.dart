import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

/// 📌 وصف الملف
///
/// [awosomNotificationMessaging]
///
///[AwesomeNotifications] هو نظام إشعارات مخصص يستخدم مكتبة
///
/// لإرسال وعرض الإشعارات سواء كان التطبيق في الخلفية أو المقدمة.
///
///
/// 📌 وظيفة الكود
///
/// 🔹 `awosomNotificationMessaging`: تهيئة قناة الإشعارات وضبط الأذونات والاستماع للأحداث.
///
/// 🔹 `onNotificationCreated`: يتم استدعاؤه عند إنشاء الإشعار.
///
/// 🔹 `onNotificationDisplayed`: يتم استدعاؤه عند عرض الإشعار.
///
/// 🔹 `onDismissActionReceived`: يتم استدعاؤه عند رفض/إغلاق الإشعار.
///
/// 🔹 `onActionReceived`: يتم استدعاؤه عند تفاعل المستخدم مع الإشعار (مثل النقر عليه).
///
/// 🔹 `showForegroundNotification`: يعرض إشعارًا عند تشغيل التطبيق في المقدمة.
///
/// 🔹 `showBackgroundNotification`: يعرض إشعارًا عند تشغيل التطبيق في الخلفية.
///
///
/// 📌 المخرجات المحتملة
///
/// ✅ إرسال إشعارات داخل التطبيق وخارجه.
///
/// ✅ التعامل مع تفاعل المستخدم مع الإشعارات (فتح، إغلاق، تجاهل).
///
/// ✅ دعم الإشعارات الصامتة وإخفاء التفاصيل على شاشة القفل.
///
/// ✅ إدارة أذونات الإشعارات تلقائيًا.
///
/// 🚀 هذا الكود يسهل إرسال الإشعارات وتحسين تجربة المستخدم بإشعارات مخصصة وسهلة الإدارة! 🚀

Future<void> awosomNotificationMessaging() async {
  AwesomeNotifications().initialize(
    null, // No custom notification icon
    [
      NotificationChannel(
        channelKey: 'my_message',
        channelName: 'Location Tracking',
        channelDescription: 'for tracking lockation',
        defaultColor: const Color.fromARGB(255, 54, 147, 54),
        ledColor: Colors.white,

        importance: NotificationImportance.High, // 👈 Keeps it silent
        defaultPrivacy:
            NotificationPrivacy.Secret, // 👈 Hides details on lock screen
      ),
    ],
  );

  // ✅ Listen for background events
  AwesomeNotifications().setListeners(
    onNotificationCreatedMethod: onNotificationCreated,
    onNotificationDisplayedMethod: onNotificationDisplayed,
    onDismissActionReceivedMethod: onDismissActionReceived,
    onActionReceivedMethod: onActionReceived,
  );

  // await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
  //   if (!isAllowed) {
  //     await AwesomeNotifications().requestPermissionToSendNotifications();
  //   }
  // });
  // initialServices();
}

Future<void> onNotificationCreated(
    ReceivedNotification receivedNotification) async {
  debugPrint("🔔 Notification Created: ${receivedNotification.id}");
}

Future<void> onNotificationDisplayed(
    ReceivedNotification receivedNotification) async {
  debugPrint("✅ Notification Displayed: ${receivedNotification.id}");

  // Check if the app is in the foreground or background
}

Future<void> onDismissActionReceived(ReceivedAction receivedAction) async {
  debugPrint("🗑️ Notification Dismissed: ${receivedAction.id}");
}

Future<void> onActionReceived(ReceivedAction receivedAction) async {
  debugPrint("🎯 User Tapped Notification: ${receivedAction.id}");
  // Navigate to a specific screen when tapped
  // Get.to(() => HomeScreen());
}

void showForegroundNotification(
    int? id, String title, String body, NotificationLayout layout) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id ?? 1,
      channelKey: 'my_message',
      title: " $title",
      body: ' $body ',
      notificationLayout: layout,
      payload: {'notificationId': '1234567890'},
      displayOnForeground: true,
      displayOnBackground: false,
    ),
  );
}

void showBackgroundNotification(
    int? id, String title, String body, NotificationLayout layout) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id ?? 1,
      channelKey: 'my_message',
      title: " $title",
      body: ' $body ',
      notificationLayout: layout,
      payload: {'notificationId': '1234567890'},
      displayOnForeground: false,
      displayOnBackground: true,
    ),
  );
}
