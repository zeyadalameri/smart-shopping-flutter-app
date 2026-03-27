import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/constants/app_image_assets.dart';
import 'package:smart_shopping_fe/core/constants/app_routes_names.dart';

// ✅ 1. إنشاء Controller
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    Future.delayed(
      Duration(seconds: 2),
      () {
        Get.offNamed(AppRoutes.start); // ✅ الانتقال باستخدام المسار
      },
    );
  }
}

// ✅ 3. شاشة Splash Screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<SplashController>(SplashController());
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage(AppImageAsset.logo),
          radius: 50,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
