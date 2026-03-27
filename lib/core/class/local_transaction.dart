import 'dart:convert';

import 'package:get/get.dart';
import '/core/services/services.dart';

/// 📌 وصف الملف
///
/// تُستخدم لإدارة البيانات المخزنة محليًا باستخدام [LocalTransaction] كلاس
///
/// [sharedPreferences]
///
///[JSON] وتوفير واجهات لتخزين واسترجاع البيانات بصيغة
///
///[MyServices] الكلاس تعتمد على خدمة
///
/// [sharedPreferences] للحصول على الوصول إلى
///
/// 📌 وظيفة الكود
///
/// 🔹 1. getData(String key) -المحدد [key] لاسترجاع البيانات المخزنة باستخدام المفتاح
///
///  -وإرجاعها  (JSON) يقوم الكود بمحاولة فك تشفير البيانات المخزنة
///
///    -[null] في حالة حدوث خطأ أو عدم وجود البيانات، تُرجع
///
/// 🔹 2. setData(String key, Map data) -[JSON] بعد تحويلها إلى [sharedPreferences] لحفظ البيانات في
///
///    -[false] وإذا فشلت تُرجع , [true]  إذا تمت العملية بنجاح، تُرجع
///
///    -لضمان استقرار التطبيق. (Errors) يتم التعامل مع الاستثناءات
///

/// 📌 المخرجات المحتملة
///
/// ✅ إذا كانت البيانات موجودة وتم استرجاعها بنجاح، يتم إرجاعها بعد فك تشفيرها.
///
/// 🔄null إذا حدث خطأ في استرجاع البيانات، يتم إرجاع .
///
/// ❌false إذا فشل حفظ البيانات، تُرجع .
///
/// 🚀sharedPreferences هذا الكود يساعد في إدارة البيانات المحلية بسهولة وفعالية باستخدام ! 🚀

class LocalTransaction {
  final MyServices _myServices = Get.find();

  getData(String key) {
    try {
      String? jsonString = _myServices.sharedPreferences.getString(key);
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<bool> setData(String key, Map data) async {
    try {
      final jsonString = jsonEncode(data);
      await _myServices.sharedPreferences.setString(key, jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
