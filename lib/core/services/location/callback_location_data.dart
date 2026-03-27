import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_shopping_fe/core/class/status_request.dart';
import 'package:smart_shopping_fe/core/functions/awsome_notification_messaging.dart';
import 'package:smart_shopping_fe/core/functions/handling_transaction.dart';
import 'package:smart_shopping_fe/core/services/services.dart';
import 'package:smart_shopping_fe/core/constants/app_api_links.dart';
import 'package:smart_shopping_fe/core/class/crud_transactions.dart';
import 'package:smart_shopping_fe/core/settings/app_setting_values.dart';

class CallBackData {
  final CrudTrans crud;
  CallBackData(this.crud);

  getAllData({required String requests}) async {
    //
    var response = await crud.getData(AppApiLinks.nearestMarkets, requests);
    return response.fold((l) => l, (r) => r);
  }
}

class CallbackLocationData extends GetxController {
  CallbackLocationData();
  late MyServices myServices = Get.find();
  Rx<Position?> lastLocation = Rx<Position?>(null);
  final Distance distance = Distance();
  double distanceCm = 0;

  final CallBackData callBackData = Get.put(CallBackData(Get.put(CrudTrans())));

  Future<void> _saveLocation(double lat, double lng) async {
    await myServices.sharedPreferences.setDouble('lat', lat);
    await myServices.sharedPreferences.setDouble('lng', lng);
  }

  Future<double> getDistance(Position position) async {
    var savedLat = myServices.sharedPreferences.getDouble('lat');
    var savedLng = myServices.sharedPreferences.getDouble('lng');
    if (savedLat == null || savedLng == null) {
      await _saveLocation(position.latitude, position.longitude);
      savedLat = position.latitude;
      savedLng = position.longitude;
    }
    return distance
        .as(
          LengthUnit.Centimeter,
          LatLng(savedLat, savedLng),
          LatLng(position.latitude, position.longitude),
        )
        .toDouble();
  }

  getData(Position position, ServiceInstance service) async {
    lastLocation.value = position;
    distanceCm = await getDistance(position);
    update();
    if (distanceCm >= AppSettingValues.distanceThresholdCm &&
        (_callBackStatusRequest != StatusRequest.loading)) {
      service.invoke("status", {"status": false});
      await _saveLocation(position.latitude, position.longitude);
      Map? dataMap = await getDataFromServer(
          position,
          // AppSettingValues.distanceRadiusM
          1000);
      service.invoke("status", {"status": true});
      service.invoke("update", {"data": dataMap});
      debugPrint(
          "Location: ${position.latitude}, ${position.longitude} , data");
    }

    // }
  }

  StatusRequest? _callBackStatusRequest;
  getDataFromServer(Position position, int radius) async {
    _callBackStatusRequest = StatusRequest.loading;
    update();
    var response = await callBackData.getAllData(
        requests:
            'latitude=${position.latitude}&longitude=${position.longitude}&radius=$radius');

    _callBackStatusRequest = handlingTransaction(response);
    update();
    try {
      if (_callBackStatusRequest == StatusRequest.success) {
        List m = response['OfferModel'] ?? [];

        if (m.isNotEmpty) {
          showBackgroundNotification(8000000, "مرحبا", "هناك عروض قريبة منك",
              NotificationLayout.Inbox);
        }
      }
      // print(response);
      return response;
    } catch (e) {
      return {"markets": [], "categories": [], "offers": []};
    }
  }
}
