import 'package:smart_shopping_fe/core/class/local_transaction.dart';

class HomePageStorage {
  final LocalTransaction crud;
  HomePageStorage(this.crud);

  getData(String key) {
    var response = crud.getData(key);
    return response;
  }

  Future<bool> setData(String key, Map data) async {
    var response = await crud.setData(key, data);
    return response;
  }
}
