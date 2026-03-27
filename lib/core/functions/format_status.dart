/// 📌 وصف الملف
///
/// [formatStatus]
///
/// (`status`) هي دالة تقوم بتحويل كود الحالة
///
/// (`active` أو `inActive`) إلى نصوص مقروءة
///
/// 📌 وظيفة الكود
///
/// 🔹"inActive" ترجع null تساوي status إذا كانت
///
/// 🔹"active" ترجع status = 1 إذا كانت
///
/// 🔹 "inActive" في أي حالة أخرى، ترجع
///
/// 📌 المخرجات المحتملة
///
/// ✅ `1` → `"active"`
/// ✅ `null` ,  `1` , 'else' → `"inActive"`
///
/// 🚀 هذه الدالة مفيدة لتنسيق حالات الكيانات داخل التطبيق! 🚀

// ignore_for_file: dangling_library_doc_comments

String formatStatus(int? status) {
  if (status == null) {
    return "inActive";
  }
  switch (status) {
    case 1:
      return "active";
    default:
      return "inActive";
  }
}
