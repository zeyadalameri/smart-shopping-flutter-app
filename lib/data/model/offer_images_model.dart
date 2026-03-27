import 'package:smart_shopping_fe/core/constants/app_api_links.dart';

class OfferImagesModel {
  int? id;
  int? offerId;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  OfferImagesModel(
      {this.id, this.offerId, this.imageUrl, this.createdAt, this.updatedAt});

  OfferImagesModel.fromJson(Map<String, dynamic> json) {
    String imagePath =
        (json['imageUrl'] ?? AppApiLinks.serverImageError).toString();
    id = json['id'];
    offerId = json['offer_id'];
    imageUrl = imagePath.contains('http://') || imagePath.contains('https://')
        ? imagePath
        : AppApiLinks.server + AppApiLinks.image + imagePath;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offer_id'] = offerId;
    data['imageUrl'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
