import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_json_image_assets.dart';

/// 📌 وصف الملف
///
///   وهو مسؤول عن إرسال واستقبال البيانات [CrudTrans] هذا الملف يحتوي على كلاس
///
/// "HTTP" من وإلى السيرفر باستخدام بروتوكول
///
/// لتنفيذ الطلبات [http] يعتمد على مكتبة
///
/// [Either،] لإدارة الأخطاء عبر  [dartz]  كما يستخدم
///
/// بحيث يتم التعامل مع  الاستجابات بالنجاح أو الفشل
///
class HandingImageNetwork extends StatelessWidget {
  const HandingImageNetwork(
      {super.key,
      required this.imageUrl,
      this.filterQuality = FilterQuality.medium,
      this.placeholderWidget,
      this.errorWidget,
      required this.errorText,
      this.height = 140,
      this.width = double.infinity});

  final String imageUrl; //getGoogleDriveImageUrl(advData.imagePath!)
  final FilterQuality filterQuality;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final String errorText;
  final double? height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return imageUrl.trim().isEmpty
        ? errorWidget ?? const Icon(Icons.broken_image_outlined)
        : CachedNetworkImage(
            imageUrl: (imageUrl),

            height: height,
            width: width,
            fit: BoxFit.fill, // Ensure image takes the full width of its parent
            filterQuality: FilterQuality.medium,
            placeholder: (context, url) =>
                placeholderWidget ??
                Center(
                    child: Lottie.asset(AppJasonImageAsset.imageLoading,
                        height: height,
                        width: width,
                        repeat: true,
                        fit: BoxFit.fill)), //width: 70, height: 100
            errorWidget: (context, url, error) => Center(
                child: errorWidget ?? const Icon(Icons.broken_image_outlined)),
            errorListener: (e) {
              if (e is SocketException) {
                debugPrint(
                    'Error with ${e.address} and message ${e.message}  Page: $errorText  uri: $imageUrl');
              } else {
                debugPrint(
                    'Image Exception is: ${e.runtimeType}   Page: $errorText  uri: $imageUrl');
              }
            },
          );
  }
}
