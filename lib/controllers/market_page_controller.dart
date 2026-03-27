import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/core/class/status_request.dart';
import 'package:smart_shopping_fe/core/constants/app_routes_names.dart';
import 'package:smart_shopping_fe/core/functions/handling_transaction.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';
import 'package:smart_shopping_fe/data/remote/market_page_data.dart';

abstract class MarketPageControllerImp extends GetxController {
  //
  getData();
  goToDetailsPage(Map<String, dynamic> offer);
}

class MarketPageController extends MarketPageControllerImp {
  List offers = [];
  late MarketModel market;
  final FavoritesPageController favoritesController = Get.find();

  @override
  void onInit() {
    market = MarketModel.fromJson(Get.arguments['market']);
    getData();
    super.onInit();
  }

  StatusRequest? statusRequest;
  MarketPageData marketPageData = MarketPageData(Get.find());
  @override
  getData() async {
    statusRequest = StatusRequest.loading;

    var response =
        await marketPageData.getData(requests: "market_id[eq]=${market.id}");

    statusRequest = handlingTransaction(response);

    if (statusRequest == StatusRequest.success) {
      offers.clear();
      offers.addAll(response['data']);
    }

    update();
  }

  @override
  void goToDetailsPage(Map<String, dynamic> offer) async {
    await Get.toNamed(AppRoutes.offerDetailsPage, arguments: {'offer': offer});
    update();
  }

  Future<void> onRefresh() async {
    await getData();
    return;
  }
}
