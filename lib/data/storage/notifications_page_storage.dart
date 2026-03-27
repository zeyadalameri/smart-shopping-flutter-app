import 'package:smart_shopping_fe/core/class/local_transaction.dart';

class NotificationsPageStorage {
  final LocalTransaction crud;
  NotificationsPageStorage(this.crud);

  getData(String key) {
    var response = crud.getData(key);
    List data1 = response["data"] ?? [];
    return data1;
  }

  Future<bool> setData(String key, List<Map>? data) async {
    Map data1 = {"data": data ?? []};
    var response = await crud.setData(key, data1);
    return response;
  }

  Future<bool> clearAll(String key) async {
    Map data1 = {"data": []};
    var response = await crud.setData(key, data1);
    return response;
  }
}
