import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'package:smart_shopping_fe/data/model/offer_model.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class OfferDetailsPageControllerImp extends GetxController {
  //
}

class OfferDetailsPageController extends OfferDetailsPageControllerImp {
  late OfferModel offer;
  late PageController pageController;
  final FavoritesPageController favorite = Get.find();
  bool inFavorite = false;
  MyServices myServices = Get.find();
  int selectedImageIndex = 0;
  @override
  void onInit() {
    offer = OfferModel.fromJson(Get.arguments['offer']);
    pageController = PageController(viewportFraction: 0.7);
    super.onInit();
  }

  Future<void> openExternalMap(double lat, double lng) async {
    final googleMapsUrl = Uri.parse("comgooglemaps://?q=$lat,$lng");
    final appleMapsUrl = Uri.parse("https://maps.apple.com/?q=$lat,$lng");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    }
    // Then try Apple Maps (iOS only)
    else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    }
  }

  void onChangeImage(int index) {
    selectedImageIndex = index;
    update();
  }
}
