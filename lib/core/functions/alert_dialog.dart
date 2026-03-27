import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';

/// 📌 وصف الملف
///
/// [myAlertDialog]
///
///[GetX] باستخدام  (Alert Dialog) هي دالة مخصصة لإنشاء وعرض مربع حوار
///
/// توفر الدالة طريقة سهلة لعرض رسائل تحذيرية
///
/// أو تأكيدية مع أزرار قابلة للتخصيص
///
/// 📌 وظيفة الكود
///
/// 🔹 `title`: عنوان مربع الحوار.
///
/// 🔹 `message`: الرسالة التي سيتم عرضها داخل مربع الحوار.
///
/// 🔹 `barrierDismissible`: يحدد ما إذا كان يمكن إغلاق مربع الحوار بالنقر خارج النوافذ (افتراضي: `true`).
///
/// 🔹 `confirmColor`: لون زر التأكيد (افتراضي: `أخضر`).
///
/// 🔹 `cancelColor`: لون زر الإلغاء (افتراضي: `أحمر`).
///
/// 🔹 `onConfirm`: دالة اختيارية يتم تنفيذها عند الضغط على زر التأكيد.
///
/// 🔹 `onCancel`: دالة اختيارية يتم تنفيذها عند الضغط على زر الإلغاء.
///
/// 📌 المخرجات المحتملة
///
/// ✅ عرض مربع حوار مع رسالة وعنوان وأزرار تأكيد وإلغاء.
///
/// ✅ تنفيذ دوال مخصصة عند الضغط على أي من الزرين.
///
/// ✅  `Translate.cancel.tr` و `Translate.confirm.tr`دعم تعدد اللغات عبر
///
/// 🚀 تسهل هذه الدالة التعامل مع مربعات الحوار في التطبيق بطريقة مرنة وقابلة للتخصيص! 🚀

void myAlertDialog({
  required String title,
  required String message,
  bool barrierDismissible = true,
  Color confirmColor = Colors.green,
  Color cancelColor = Colors.red,
  Function()? onConfirm,
  Function()? onCancel,
}) {
  Get.defaultDialog(
    title: title,
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16),
    ),
    barrierDismissible:
        barrierDismissible, // Allow dismissing dialog by tapping outside

    actions: [
      TextButton(
        onPressed: () {
          Get.back();
          if (onCancel != null) onCancel();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red.withAlpha(30),
          ),
          child: Text(
            Translate.cancel.tr,
            style: TextStyle(color: cancelColor),
          ),
        ),
      ),
      SizedBox(
        width: 30,
      ),
      TextButton(
        onPressed: () {
          Get.back();
          if (onConfirm != null) onConfirm();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            Translate.confirm.tr,
            style: TextStyle(color: confirmColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
