import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_shopping_fe/core/constants/app_json_image_assets.dart';

/// 📌 وصف الملف
///
///  هي ويدجت ثابتة تُستخدم لعرض رسالة أو أنيميشن عند عدم وجود بيانات [NoDataCard] كلاس
///
///[JSON] لعرض أنيميشن مخصص من ملف  [Lottie] تعتمد على مكتبة
///
/// 📌 وظيفة الكود
///
/// 🔹 `text`: نص يتم تمريره إلى الويدجت، لكنه غير مستخدم في هذا الكود.
/// 🔹 [Lottie.asset] يتم عرض أنيميشن "لا توجد بيانات" باستخدام
///
/// 📌 المخرجات المحتملة
///
/// ✅ يتم عرض أنيميشن ثابت في حالة عدم وجود بيانات.

class NoDataCard extends StatelessWidget {
  const NoDataCard({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Lottie.asset(AppJasonImageAsset.noData,
                width: 150, height: 150, repeat: false, fit: BoxFit.cover)),
      ),
    );
  }
}
