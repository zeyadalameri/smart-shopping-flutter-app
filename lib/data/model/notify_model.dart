class NotifyModel {
  final String? id; // Unique ID for the notification
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? timestamp;
  final bool? isRead;
  final NotificationType? type; // Enum to categorize notifications
  final String? actionUrl; // URL or deep link to navigate user

  NotifyModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.timestamp,
    this.isRead = false,
    this.type,
    this.actionUrl,
  });

  /// Convert Notification to JSON (for local storage or API)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "timestamp": timestamp,
      "isRead": isRead,
      "type": type.toString(),
      "actionUrl": actionUrl,
    };
  }

  /// Convert JSON to Notification Model
  factory NotifyModel.fromJson(Map<String, dynamic> json) {
    return NotifyModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      timestamp: json["timestamp"],
      isRead: json["isRead"] ?? false,
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == json["type"],
        orElse: () => NotificationType.general,
      ),
      actionUrl: json["actionUrl"],
    );
  }
}

/// Enum for Notification Type
enum NotificationType { general, promo, orderUpdate, message, alert }
