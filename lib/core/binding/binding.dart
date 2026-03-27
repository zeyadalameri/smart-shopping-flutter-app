import 'package:smart_shopping_fe/core/class/local_transaction.dart';
import 'package:smart_shopping_fe/core/services/location/location_service.dart';
import '../../controllers/favorites_page_controller.dart';
import '/core/class/crud_transactions.dart';
import 'package:get/get.dart';

/// هذا الكلاس يتم تعريفه في
///
/// [MaterialِApp]
///
/// والذي يقوم بتعريف الملفات الاساسية
/// التي نحتاج تعريفها قبل بدء الصفحة الرئيسية
class MyBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(CrudTrans());
    Get.put(LocalTransaction());
    Get.put(FavoritesPageController());

    if (!Get.isRegistered<LocationService>()) {
      Get.put(LocationService());
    }
  }
}
