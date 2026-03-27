import 'dart:io';
import '/core/localization/langs/translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 📌 وصف الملف
///
/// [alertExitApp]
///
///  هي دالة تعرض مربع حوار تأكيدي عند محاولة المستخدم الخروج من التطبيق.
///
///لإنشاء مربع الحوار بطريقة ديناميكية مع دعم تعدد اللغات [GetX] تعتمد على
///
///
/// 📌 وظيفة الكود
///
/// 🔹 تعرض رسالة تحذيرية للمستخدم عند محاولة إغلاق التطبيق.
///
/// 🔹 تحتوي على زرين:
///
///    - زر "نعم" لإنهاء التطبيق باستخدام `exit(0)`.
///
///    - زر "إلغاء" لإغلاق مربع الحوار والعودة للتطبيق.
///
///
/// 📌 المخرجات المحتملة
///
///
/// ✅ إظهار مربع حوار تحذيري عند محاولة الخروج.
///
/// ✅ إنهاء التطبيق في حالة تأكيد المستخدم.
///
/// ✅ إغلاق مربع الحوار بدون الخروج عند الضغط على "إلغاء".
///
/// 🚀 تسهل هذه الدالة التعامل مع تأكيد الخروج بطريقة سلسة مع دعم تعدد اللغات! 🚀

alertExitApp() {
  return Get.defaultDialog(
      title: Translate.warning,
      middleText: Translate.alertexitingApp,
      actions: [
        ElevatedButton(
            onPressed: () {
              exit(0);
            },
            child: Text(Translate.yes)),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text(Translate.cancel)),
      ]);

  // return Future.value(true);
}
