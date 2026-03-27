/// 📌 وصف الملف
///
/// [StatusRequest]:يُستخدم لتحديد حالات مختلفة يمكن  [enum]  هو كلاس من نوع
///
/// جلب البيانات أو التعامل مع الطلبات. أن يمر بها التطبيق أثناء
///
///
///
/// 📌 وظيفة الكود
///
/// 🔹 `loading`: حالة التحميل أثناء جلب البيانات.
///
/// 🔹 `success`: حالة النجاح عند جلب البيانات بنجاح.
///
/// 🔹 `failure`: حالة الفشل عند فشل جلب البيانات.
///
/// 🔹 `serverFailure`: حالة فشل في السيرفر أثناء معالجة الطلب.
///
/// 🔹 `serverException`: حالة استثناء عام من السيرفر.
///
/// 🔹 `offlineFailure`: حالة انقطاع الاتصال بالإنترنت.
///
/// 🔹 `none`: حالة لا شيء أو لا توجد حالة حالياً.

// ignore_for_file: dangling_library_doc_comments

enum StatusRequest {
  loading,
  success,
  failure,
  serverFailure,
  serverException,
  offlineFailure,
  none,
}
