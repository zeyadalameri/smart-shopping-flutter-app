import 'package:smart_shopping_fe/core/constants/app_api_links.dart';
import 'package:smart_shopping_fe/core/class/crud_transactions.dart';

class MarketPageData {
  final CrudTrans crud;
  MarketPageData(this.crud);

  getData({String requests = ""}) async {
    var response = await crud.getData(AppApiLinks.offers, requests);
    return response.fold((l) => l, (r) => r);
  }
}
