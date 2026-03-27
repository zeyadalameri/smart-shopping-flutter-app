import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 📌 وظيفة الكود
///
/// :يحتوي على [Snackbar]
///
///🔹 [CircularProgressIndicator] عداد زمني تنازلي يظهر داخل
///
/// 🔹[contentText] نص محتوى الإشعار
///
/// 🔹 عند الضغط عليه [afterExecuteMethod] الذي ينفذ [Undo] زر
///
/// 🔹 [seconds] يتم إغلاق الإشعار تلقائيًا بعد انتهاء الوقت.
///
/// 🔹 يتم إغلاق الإشعار تلقائيًا عند انتهاء المؤقت [Undo] إذا لم يتم الضغط على
///
/// 🚀 يساعد هذا الكود في تحسين تجربة المستخدم عبر تقديم فرصة للتراجع عن الإجراءات! 🚀

void showUndoSnackbar({
  required String contentText,
  required VoidCallback afterExecuteMethod,
  int seconds = 4,
}) {
  Get.rawSnackbar(
    title: "إشعار",
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 22.0),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: seconds * 1000.toDouble()),
            duration: Duration(seconds: seconds),
            builder: (context, double value, child) {
              double remainingSeconds = (seconds - (value.toInt() / 1000));
              if (remainingSeconds == 0) {
                Get.closeCurrentSnackbar();
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value: value / (seconds * 1000),
                      color: Colors.grey[850],
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Center(
                    child: Text(
                      (remainingSeconds.toInt()).toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            contentText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        InkWell(
          splashColor: Colors.white,
          onTap: () {
            Get.closeCurrentSnackbar();
            afterExecuteMethod();
          },
          child: Container(
            color: Colors.grey[850],
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "Undo",
              style: TextStyle(color: Colors.blue[100]),
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.black87,
    borderRadius: 10,
    duration: const Duration(days: 1), // Keep snackbar open indefinitely
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(6.0),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOut,
    reverseAnimationCurve: Curves.easeIn,
  );
}
