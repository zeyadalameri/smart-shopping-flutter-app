import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/binding/binding.dart';
import 'package:smart_shopping_fe/core/localization/controller/locale_controller.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/core/localization/theme/dark_theme.dart';
import 'package:smart_shopping_fe/core/localization/theme/light_theme.dart';
import 'package:smart_shopping_fe/core/services/location/location_service.dart';
import 'package:smart_shopping_fe/core/services/permissions.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'core/constants/app_routes_names.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialServices();
  try {
    await PermissionService().requestNotificationPermissionsWithAwesome();
    await PermissionService().requestLocationPermission();
    await PermissionService().requestBatteryOptimizationPermission();
  } catch (e) {
    debugPrint('======================== there is an issue');
  }
  debugPrint('========================init requestPermissions');
  await initializeBackService();
  debugPrint('========================init background');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LcaleController controller = Get.put(LcaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyLocales(),
      fallbackLocale: const Locale('en', 'US'),
      locale: controller.language ?? Locale('en', 'US'),
      title: "smart Shopping",
      theme: LightTheme.get(controller.getTextLocale()),
      darkTheme: DarkTheme.get(controller.getTextLocale()),
      initialBinding: MyBinding(),
      initialRoute: AppRoutes.splash, // ✅ تحديد الشاشة الأولى عند تشغيل التطبيق
      builder: (context, child) {
        return AnimatedTheme(
          data: controller.getTheme(),
          curve: Curves.easeInOut,
          child: child!,
        );
      },
      getPages: routesPages,
    );
  }
}
