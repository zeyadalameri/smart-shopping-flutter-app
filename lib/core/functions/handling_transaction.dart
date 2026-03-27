import '/core/class/status_request.dart';

/// 📌 وصف الملف
///
/// [handlingTransaction]
///
///  هي دالة لمعالجة استجابات العمليات وتحديد حالة الطلب.
///
handlingTransaction(response,
    [StatusRequest statusOnFailure = StatusRequest.failure]) {
  if (response is StatusRequest) {
    return response;
  } else {
    if (response['status'] == 'success') {
      return StatusRequest.success;
    }
    return statusOnFailure;
  }
}
