import 'package:smart_shopping_fe/core/constants/app_api_links.dart';
import 'package:smart_shopping_fe/core/class/crud_transactions.dart';

class HomePageData {
  final CrudTrans crud;
  HomePageData(this.crud);

  getAllData({required String requests}) async {
    //
    var response = await crud.getData(AppApiLinks.nearestMarkets, requests);
    return response.fold((l) => l, (r) => r);
  }
}
