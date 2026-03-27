/// 📌 وصف الملف
///
/// [AppJasonImageAsset]
///
/// هو كلاس تحتوي على أسماء الصور المتحركة المستخدمة في التطبيق.
///
/// يتم تخزين أسماء الصور المتحركة التي يتم استخدامها
///
/// في واجهات المستخدم بحيث يمكن الوصول إليها بسهولة
///
class AppJasonImageAsset {
  static const String _rootAsset = 'assets/lottie';

  static const String loading = '$_rootAsset/loading3.json';
  static const String imageLoading = '$_rootAsset/image_loading.json';
  //
  static const String offline = '$_rootAsset/offline.json';
  static const String noData = '$_rootAsset/nodata.json';
  static const String serverError = '$_rootAsset/server.json';
  static const String discountOrange = '$_rootAsset/discount-orange.json';
}
