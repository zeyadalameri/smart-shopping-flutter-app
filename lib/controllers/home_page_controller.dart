import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/core/class/status_request.dart';
import 'package:smart_shopping_fe/core/constants/app_routes_names.dart';
import 'package:smart_shopping_fe/core/functions/handling_transaction.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/core/services/location/location_service.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'package:smart_shopping_fe/core/settings/app_setting_values.dart';
import 'package:smart_shopping_fe/data/remote/home_page_data.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_shopping_fe/data/storage/home_page_storage.dart';

// import '../data/model/offer_model.dart';

abstract class HomePageControllerImp extends GetxController {
  //
  getNearestMarketsData(LatLng location, int radius);
  goToDetailsPage(Map<String, dynamic> offer);
  goToMarket(int index);
  // checkIfFavoriete(int id);
  // removeFromFavorite(OfferModel offer);
  // addToFavorite(OfferModel offer);
  // getNearestoffersData(int radius, int index);
}

class HomePageController extends HomePageControllerImp {
  final LocationService locationService = Get.find<LocationService>();
  late PageController offersPageController;
  late PageController pageController;
  StatusRequest? marketsStatusRequest;
  StatusRequest? offersStatusRequest;
  StatusRequest? callBackStatusRequest;
  HomePageData homePageData = HomePageData(Get.find());
  HomePageStorage homePageStorage = HomePageStorage(Get.find());
  final FavoritesPageController favoritesController = Get.find();

  //
  MyServices myServices = Get.find();
  int selectedCategoryIndex = 0;
  int selectedMarketIndex = 0;
  int selectedTapIndex = 0;
  List tapCategories = [];
  Map dataMap = {}; // Sample data
  List markets = []; // Sample data
  List allMarketOffers = []; // Sample offers
  List categories = []; // Sample categories
  List setOffers = []; // all offers
  List offers = []; // spesafic offers

  int radius = 100000;

  @override
  void onInit() {
    super.onInit();
    initdata();
    getForTheFirstTime();
    offersPageController = PageController();
    pageController = PageController(viewportFraction: 0.7);

    FlutterBackgroundService().on('status').listen(
      (event) async {
        if (event != null && event['status'] != null) {
          callBackStatusRequest =
              event['status'] ? StatusRequest.success : StatusRequest.loading;

          update();
        }
      },
    );
    FlutterBackgroundService().on('update').listen(
      (event) async {
        if (selectedTapIndex == 1) {
          if (event != null && event['data'] != null) {
            dataMap = event['data'];

            markets.clear();
            markets.addAll((dataMap['markets'] ?? []));

            await onChangeMarket(0);
          }
        }
      },
    );

    pageController.addListener(() {
      int newIndex = pageController.page!.round();
      if (newIndex != selectedMarketIndex) {
        selectedMarketIndex = newIndex;
        update();
      }
    });
  }

  initdata() {
    tapCategories = [
      {
        'name': Translate.all,
        'onTap': () async {
          radius = 100000;
          if (marketsStatusRequest != StatusRequest.loading) {
            marketsStatusRequest = StatusRequest.loading;
            update();
            Position loc = await locationService.getCurrentLocation();

            await getNearestMarketsData(
                LatLng(loc.latitude, loc.longitude), radius);
          }
        }
      },
      {
        'name': Translate.nearest,
        'onTap': () async {
          radius = AppSettingValues.distanceRadiusM;
          if (marketsStatusRequest != StatusRequest.loading) {
            marketsStatusRequest = StatusRequest.loading;
            update();
            Position loc = await locationService.getCurrentLocation();

            await getNearestMarketsData(
                LatLng(loc.latitude, loc.longitude), radius);
          }
        }
      }
    ];
  }

  void onChangeTap(int index) {
    selectedTapIndex = index;
    tapCategories[index]['onTap']();
    update();
  }

  Future onCategoryChanges(int index) async {
    selectedCategoryIndex = index;

    offers = allMarketOffers
        .where((element) => element['category_id'] == categories[index]['id'])
        .toList();
    update();
  }

  getForTheFirstTime() async {
    if (marketsStatusRequest != StatusRequest.loading) {
      marketsStatusRequest = StatusRequest.loading;
      update();
      Position loc = await locationService.getCurrentLocation();

      await getNearestMarketsData(LatLng(loc.latitude, loc.longitude), radius);
    }
  }

  @override
  getNearestMarketsData(LatLng location, int radius) async {
    marketsStatusRequest = StatusRequest.loading;
    update();
    var response = await homePageData.getAllData(
        requests:
            'latitude=${location.latitude}&longitude=${location.longitude}&radius=$radius');

    marketsStatusRequest = handlingTransaction(response);

    try {
      if (marketsStatusRequest == StatusRequest.success) {
        offersStatusRequest = StatusRequest.success;

        dataMap.addAll(response);
        if (selectedTapIndex == 0) {
          homePageStorage.setData('home_page_all_data', dataMap);
        }
        // await onChangeMarket(0);
      } else if (marketsStatusRequest == StatusRequest.offlineFailure &&
          selectedTapIndex == 0) {
        marketsStatusRequest = StatusRequest.success;
        var data = homePageStorage.getData('home_page_all_data');
        if (data != null) {
          dataMap.addAll(data);
        }
      }
      markets.clear();
      markets.addAll(dataMap['markets']);
      await onChangeMarket(0);
    } catch (e) {
      //
      marketsStatusRequest = StatusRequest.serverException;
    }
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    offersPageController.dispose();
    super.onClose();
  }

  @override
  dispose() {
    pageController.dispose();
    offersPageController.dispose();

    super.dispose();
  }

  Future<void> onChangeMarket(int index) async {
    offersStatusRequest = StatusRequest.loading;
    update();

    if (dataMap['offers']?.isNotEmpty ??
        false || (dataMap['category']?.isNotEmpty ?? false)) {
      final market = MarketModel.fromJson(markets[index]);
      // Filter offers for the selected market
      allMarketOffers =
          dataMap['offers']!.where((e) => e['market_id'] == market.id).toList();

      // Use a Map to store unique categories by ID
      final Map<int, dynamic> categoriesMap = {
        for (var e in allMarketOffers) e['category']['id']: e['category']
      };

      categories = categoriesMap.values.toList();

      await onCategoryChanges(0);
    } else {
      allMarketOffers.clear();
      offers.clear();
      categories.clear();
    }
    offersStatusRequest = StatusRequest.success;

    update();
  }

  Future<void> onRefreshPage() async {
    Position loc = await locationService.getCurrentLocation();

    await getNearestMarketsData(LatLng(loc.latitude, loc.longitude), radius);

    return;
  }

  @override
  void goToMarket(int index) {
    Get.toNamed(AppRoutes.marketPage, arguments: {"market": markets[index]});
  }

  @override
  void goToDetailsPage(Map<String, dynamic> offer) async {
    offer["market"] =
        markets.firstWhere((element) => element['id'] == offer['market_id']);
    await Get.toNamed(AppRoutes.offerDetailsPage, arguments: {'offer': offer});
    update();
  }

  // @override
  // checkIfFavoriete(int id) {
  //   return (favoritesController.offers
  //       .where((element) => element['id'] == id)
  //       .isNotEmpty);
  // }

  // @override
  // addToFavorite(OfferModel offer) async {
  //   await favoritesController.addToFavorite(offer);
  //   update();
  // }

  // @override
  // removeFromFavorite(OfferModel offer) async {
  //   await favoritesController.removeFromFavorite(offer);
  //   update();
  // }
}
