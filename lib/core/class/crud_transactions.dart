import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/services/services.dart';
import '../constants/app_api_links.dart';
import '/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;

import 'status_request.dart';

class CrudTrans {
  final MyServices _myServices = Get.find();
  Future<Either<StatusRequest, Map>> postData(
      String requestName, Map data) async {
    try {
      if (await checkInternet()) {
        String? token = _myServices.sharedPreferences.getString('token');
        var response =
            await http.post(Uri.parse('${AppApiLinks.server}/$requestName'),
                headers: {
                  'Accept': '*application/json',
                  'Authorization':
                      'Bearer $token', // Pass the token in the Authorization header
                },
                body: data);
        debugPrint('=====================================');
        debugPrint(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          debugPrint(response.body);
          debugPrint('=====================================');
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.offlineFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String requestName, String? data) async {
    try {
      if (await checkInternet()) {
        String? token = _myServices.sharedPreferences.getString('token');
        String? request = data == '' ? "" : "?$data";

        debugPrint("${AppApiLinks.server}/$requestName$request =============");
        var response = await http.get(
          Uri.parse("${AppApiLinks.server}/$requestName$request"),
          headers: {
            'Accept': '*application/json',
            'Authorization': 'Bearer $token',
          },
        );

        // debugPrint('Request URL: ${AppApiLinks.server}/$requestName?$data');
        // debugPrint('Response Body: ${response.statusCode}============');
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          // debugPrint('Response Body: $responseBody============');
          // debugPrint('Response Body: ============');
          return Right(responseBody);
        } else {
          // debugPrint('Server Error: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        // debugPrint('No Internet Connection');
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      // debugPrint('Error: $e');
      return const Left(StatusRequest.serverException);
    }
  }
}
