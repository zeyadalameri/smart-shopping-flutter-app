import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_json_image_assets.dart';
import 'status_request.dart';

///  📌 وصف الملف
///
/// والتي تُستخدم  "[HandlingDataView]" هذا الملف يحتوي على ويدجت
///
/// لإدارة حالات استرجاع البيانات من السيرفر وعرض واجهة مستخدم مناسبة لكل حالة
///
/// "[StatusRequest]"  يتم التعامل مع الحالات المختلفة عبر متغير
///
/// لتحديد ما إذا كان التطبيق في حالة تحميل، نجاح، فشل، انقطاع إنترنت أو خطأ في السيرفر
///

///  📌 وظيفة الكود
///
/// 🔹[ child]: الويدجت الرئيسية التي يتم عرضها عند نجاح جلب البيانات.
///
/// 🔹[statusRequest]: يعرض عناصر مختلفة بناءً على
///
///  loading →  يعرض أنيميشن تحميل
///
///  offlineFailure → يعرض رسالة انقطاع الإنترنت.
///
///  serverFailure → يعرض خطأ في السيرفر.
///
///  failure → يعرض رسالة تفيد بعدم توفر البيانات.
///
///  serverException → يعرض خطأ عام من السيرفر.
///
///  success → [child] يعرض الويدجت
///
///  🔹... إلخ [onLoadingWidget]، [onOfflineWidget] يمكن تمرير ويدجت مخصصة لكل حالة عبر
///
///  🔹[onOfflineShowChild] مثل Boolean بدلًا من ويدجت الخطأ عبر  [child] يدعم إظهار
///

///  📌 المخرجات المحتملة
///
///  ✅ يتم عرض البيانات عند نجاح جلبها من السيرفر.
///
///  🔄 يتم عرض أنيميشن تحميل أثناء تحميل البيانات.
///
///  ❌ يتم عرض رسالة خطأ إذا حدثت مشكلة في السيرفر أو الاتصال.
///
///  🌐 يتم عرض رسالة انقطاع الإنترنت إذا كان الجهاز غير متصل.

/// 🚀 هذا الكود يساعد في تحسين تجربة المستخدم من خلال إدارة حالات التحميل والأخطاء بسهولة! 🚀

class HandlingDataView extends StatelessWidget {
  /// The current status for which we'll display a corresponding UI.
  final StatusRequest? statusRequest;

  /// The main widget to display when [statusRequest] is [StatusRequest.success],
  /// or when the relevant "ShowChild" boolean is `true`.
  final Widget child;

  // Optional override widgets
  final Widget? onLoadingWidget;
  final Widget? onEmptyWidget;
  final Widget? onOfflineWidget;
  final Widget? onServerErrorWidget;
  final Widget? onFailureWidget;

  // Booleans to decide whether to show [child] instead of an error/empty widget
  final bool onEmptyShowChild;
  final bool onOfflineShowChild;
  final bool onServerErrorShowChild;
  final bool onFailureShowChild;
  final bool onLoadingShowChild;

  const HandlingDataView({
    super.key,
    required this.statusRequest,
    required this.child,

    // Booleans for controlling whether to show [child] instead of default error widgets
    this.onEmptyShowChild = false,
    this.onOfflineShowChild = false,
    this.onServerErrorShowChild = false,
    this.onFailureShowChild = false,
    this.onLoadingShowChild = false,

    // Optional overrides for default widgets
    this.onEmptyWidget,
    this.onLoadingWidget,
    this.onOfflineWidget,
    this.onServerErrorWidget,
    this.onFailureWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
        return onLoadingShowChild
            ? child
            : (onLoadingWidget ?? _buildLoading());
      case StatusRequest.offlineFailure:
        return onOfflineShowChild
            ? child
            : (onOfflineWidget ?? _buildOfflineFailure());
      case StatusRequest.serverFailure:
        return onServerErrorShowChild
            ? child
            : (onServerErrorWidget ?? _buildServerFailure());
      case StatusRequest.failure:
        // "Empty" or generic failure scenario
        return onFailureShowChild
            ? child
            : (onFailureWidget ?? _buildGenericFailure());
      case StatusRequest.serverException:
        return _buildServerException();
      case StatusRequest.success:
      default:
        return child;
    }
  }

  // ---------------------------------------------------------------------------
  // Private helper methods for default Lottie animations
  // ---------------------------------------------------------------------------

  Widget _buildLoading() => Center(
        child: Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Center(
                child: Lottie.asset(
                  AppJasonImageAsset.loading,
                  width: 100,
                  height: 100,
                ),
              ),
            )),
      );

  Widget _buildOfflineFailure() => Center(
        child: Container(
          height: 200,
          width: 200,
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Center(
              child: Lottie.asset(
                AppJasonImageAsset.offline,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      );

  Widget _buildServerFailure() => Center(
        child: Container(
          height: 200,
          width: 200,
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Center(
              child: Lottie.asset(
                AppJasonImageAsset.serverError,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      );

  /// Generic "failure" or "empty data" animation
  Widget _buildGenericFailure() => Center(
        child: Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Lottie.asset(
                AppJasonImageAsset.noData,
                width: 100,
                height: 100,
                repeat: false,
              ),
            )),
      );

  Widget _buildServerException() => Center(
        child: Container(
          height: 200,
          width: 200,
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Center(
              child: Lottie.asset(
                AppJasonImageAsset.serverError,
                width: 100,
                height: 100,
                repeat: false,
              ),
            ),
          ),
        ),
      );
}
