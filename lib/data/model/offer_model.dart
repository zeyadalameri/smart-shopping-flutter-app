import 'package:smart_shopping_fe/data/model/category_model.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';
import 'package:smart_shopping_fe/data/model/offer_images_model.dart';

class OfferModel {
  int? id;
  int? catagoryId;
  int? marketId;
  String? title;
  String? description;
  String? imageUrl;
  int? discount;
  double? price;
  int? status;
  String? startDate;
  String? endDate;
  CategoryModel? category;
  MarketModel? market;
  List<OfferImagesModel> images = [];
  //
  double? priceAfterDiscount;
  bool isFavorite = false;
  OfferModel({
    this.id,
    this.catagoryId,
    this.marketId,
    this.title,
    this.description,
    this.imageUrl,
    this.discount,
    this.price,
    this.status,
    this.startDate,
    this.endDate,
    this.category,
    this.images = const [],
    this.market,
    this.priceAfterDiscount = 0,
  });

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catagoryId = json['catagory_id'];
    marketId = json['market_id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    discount = json['discount'];
    price = double.tryParse("${json['price']}");
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];

    if (json['images'] != null) {
      images = <OfferImagesModel>[];
      json['images'].forEach((v) {
        images.add(OfferImagesModel.fromJson(v));
      });
    }
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    market =
        json['market'] != null ? MarketModel.fromJson(json['market']) : null;

    //
    priceAfterDiscount = ((double.tryParse("${json['price']}") ?? 0) *
        (1 - (json['discount'] ?? 0) / 100));
    isFavorite = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['catagory_id'] = catagoryId;
    data['market_id'] = marketId;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['discount'] = discount;
    data['price'] = price;
    data['status'] = status;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    if (images.isNotEmpty) {
      data['images'] = images.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (market != null) {
      data['market'] = market!.toJson();
    }

    return data;
  }
}
