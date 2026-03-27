import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/functions/awsome_notification_messaging.dart';
import 'package:smart_shopping_fe/core/functions/firebase_messaging.dart';
import 'package:smart_shopping_fe/core/services/location/location_service.dart';
import 'package:smart_shopping_fe/firebase_options.dart';
import '/core/functions/check_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 📌 وصف الملف

// [MyServices]
//
// يُستخدم لإعداد وتخزين الخدمات الأساسية التي يحتاجها التطبيق مثل [GetxService] هو
//
// SharedPreferences، Firebase , ،..
//
//init() وخدمات الإنترنت. يتم تهيئة هذه الخدمات عند بدء تشغيل التطبيق باستخدام دالة
//
class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  // late LocationService locationService;
  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      awosomNotificationMessaging();
      if (await checkInternet()) {
        //
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        debugPrint('=============Firebase ok=================');
        await setupFirebaseMessaging();
        debugPrint('=============setupFirebaseMessaging ok=================');
      }
    } catch (e) {
      debugPrint("$e");
    }

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
  Get.put(LocationService());
}
