import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/class/status_request.dart';
import 'package:smart_shopping_fe/core/constants/app_routes_names.dart';
import 'package:smart_shopping_fe/core/functions/show_undo_snack_bar.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';
import 'package:smart_shopping_fe/data/storage/favorite_page_storage.dart';

import '../data/model/offer_model.dart';

abstract class FavoritesPageControllerImp extends GetxController {
  void goToDetails(int index);
  void clearAll();
  addToFavorite(OfferModel offer);
  removeFromFavorite(OfferModel offerModel);
  checkIfFavoriete(int id);
  loadFavorites();
  //// for markets
  addToFavoriteMarket(MarketModel market);
  removeFromFavoriteMarket(MarketModel marketModel);
  checkIfFavorieteMarket(int id);
  loadFavoritesMarket();
  goToDetailsMarket(int index);

  ///
  onChangesTap(int index);
}

class FavoritesPageController extends FavoritesPageControllerImp
    with GetSingleTickerProviderStateMixin {
  List<Map<String, dynamic>> offers = [];
  List<Map<String, dynamic>> markets = [];
  late TabController tabController;
  List tapsList = [];
  int selectedTap = 0;
  // NotificationPageData notificationPageData = NotificationPageData(Get.find());
  FavoritePageStorage favoritePageStorage = FavoritePageStorage(Get.find());
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  String favoriteKey = 'favorite_offers';
  String favoriteKeyMarket = 'favorite_markets';

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tapsList.length, vsync: this);
    initdata();
    loadFavorites();
    loadFavoritesMarket();
  }

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
  }

  initdata() {
    tapsList = [
      {'name': Translate.offers, 'onTap': () async {}},
      {'name': Translate.markets, 'onTap': () async {}}
    ];
  }

  @override
  void goToDetails(int index) {
    Get.toNamed(AppRoutes.offerDetailsPage,
        arguments: {'offer': offers.elementAt(index)});
  }

  @override
  void goToDetailsMarket(int index) {
    Get.toNamed(AppRoutes.marketPage, arguments: {"market": markets[index]});
  }

  @override
  addToFavorite(OfferModel offer) {
    try {
      offers.add(offer.toJson());
      favoritePageStorage.setData(favoriteKey, offers);
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(title: "اشعار", messageText: const Text("هناك مشكلة"));
    }
    update();
  }

  @override
  removeFromFavorite(OfferModel offerModel) async {
    Map<String, dynamic> offer = offerModel.toJson();
    offers.removeWhere((element) => element['id'] == offer['id']);
    try {
      favoritePageStorage.setData(favoriteKey, offers);
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      showUndoSnackbar(
        contentText: "تم حذف المنتج من المفضلة",
        afterExecuteMethod: () {
          offers.add(offer);
          update();

          favoritePageStorage.setData(favoriteKey, offers);
        },
      );
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(title: "اشعار", messageText: const Text("هناك مشكلة"));
    }
    update();
  }

  @override
  loadFavorites() {
    try {
      var data = favoritePageStorage.getData(favoriteKey);
      if (data.isNotEmpty) {
        // Assign stored offers
        offers.clear();
        offers.addAll(List<Map<String, dynamic>>.from(data));
      }
    } catch (e) {
//
    }
    update();
  }

  Future<void> onRefresh() async {
    loadFavorites();
    loadFavoritesMarket();
    return;
  }

  @override
  void clearAll() async {
    await favoritePageStorage.clearAll(favoriteKey);
    await favoritePageStorage.clearAll(favoriteKeyMarket);
    offers.clear();
    markets.clear();
    update();
  }

  @override
  checkIfFavoriete(int id) {
    return (offers.where((element) => element['id'] == id).isNotEmpty);
  }

////////////////////////////// market
  @override
  addToFavoriteMarket(MarketModel market) {
    try {
      markets.add(market.toJson());
      favoritePageStorage.setData(favoriteKeyMarket, markets);
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(title: "اشعار", messageText: const Text("هناك مشكلة"));
    }
    update();
  }

  @override
  checkIfFavorieteMarket(int id) {
    return (markets.where((element) => element['id'] == id).isNotEmpty);
  }

  @override
  loadFavoritesMarket() {
    try {
      var data = favoritePageStorage.getData(favoriteKeyMarket);
      if (data.isNotEmpty) {
        // Assign stored offers
        markets.clear();
        markets.addAll(List<Map<String, dynamic>>.from(data));
      }
    } catch (e) {
//
    }
    update();
  }

  @override
  removeFromFavoriteMarket(MarketModel marketModel) {
    Map<String, dynamic> market = marketModel.toJson();
    markets.removeWhere((element) => element['id'] == market['id']);
    try {
      favoritePageStorage.setData(favoriteKeyMarket, markets);
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      showUndoSnackbar(
        contentText: "تم حذف المنتج من المفضلة",
        afterExecuteMethod: () {
          markets.add(market);
          update();

          favoritePageStorage.setData(favoriteKeyMarket, markets);
        },
      );
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.rawSnackbar(title: "اشعار", messageText: const Text("هناك مشكلة"));
    }
    update();
  }

  @override
  void onChangesTap(int index) {
    selectedTap = index;
    tapsList[index]["onTap"]();
    update();
  }
}
