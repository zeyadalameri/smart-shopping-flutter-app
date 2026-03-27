/// 📌 وصف الملف
///
/// [formatDistance]
///
/// هي دالة تقوم بتحويل قيمة المسافة من الأمتار
///
///  إلى وحدة قياس مناسبة وعرضها بشكل مقروء.
///

// ignore_for_file: dangling_library_doc_comments

String formatDistance(double? distance) {
  if (distance == null) {
    return "null";
  }
  if (distance < 0.01) {
    return '${(distance * 100).toStringAsFixed(2)} cm'; // Centimeters for very small distances
  } else if (distance < 1) {
    return '${(distance * 1000).toStringAsFixed(0)} mm'; // Millimeters for tiny distances
  } else if (distance < 1000) {
    return '${distance.toStringAsFixed(0)} m'; // Meters
  } else if (distance < 1000000) {
    return '${(distance / 1000).toStringAsFixed(2)} km'; // Kilometers
  } else if (distance < 1609344) {
    return '${(distance / 1609.344).toStringAsFixed(2)} Miles'; // Miles
  } else {
    return '${(distance / 1609.344).toStringAsFixed(0)} Miles'; // Large distances in miles (rounded)
  }
}
