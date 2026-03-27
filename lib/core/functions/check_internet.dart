import 'dart:io';

/// 📌 وصف الملف
///
/// [checkInternet]
///
///(افتراضي: Google)  هي دالة تفحص اتصال الجهاز بالإنترنت عبر محاولة الوصول إلى عنوان معين
///
///
/// 📌 وظيفة الكود
///
/// 🔹 `checkInternet([link])`: تتحقق مما إذا كان هناك اتصال بالإنترنت عن طريق `InternetAddress.lookup()`.
/// 🔹 إذا نجحت العملية وتم العثور على عنوان IP صالح، فسيتم إرجاع `true`.
/// 🔹 إذا فشل الاتصال بسبب `SocketException` (مثل عدم وجود إنترنت)، فسيتم إرجاع `false`.
///
/// 📌 المخرجات المحتملة
///
/// ✅ `true`: الجهاز متصل بالإنترنت.
/// ❌ `false`: لا يوجد اتصال بالإنترنت.
///
/// 🚀 تساعد هذه الدالة في التحقق من الاتصال بالإنترنت قبل تنفيذ العمليات التي تحتاجه! 🚀

Future<bool> checkInternet([String link = "google.com"]) async {
  try {
    var result = await InternetAddress.lookup(link);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
