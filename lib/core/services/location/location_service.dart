import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/class/crud_transactions.dart';
import 'package:smart_shopping_fe/core/services/location/callback_location_data.dart';
import 'package:smart_shopping_fe/core/services/services.dart';

/// Defines the different states of the location tracking service.
enum LocationStatus {
  unknown,
  initialized,
  running,
  stopped,
}

/// A service to manage background location tracking.
class LocationService extends GetxController {
  final FlutterBackgroundService _backgroundService =
      FlutterBackgroundService();
  double? distanceCm = 0;

  /// Subscription to the continuous location stream.
  // StreamSubscription<Position>? _locationSubscription;

  /// Provides access to local notifications.
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Exposes the current location tracking status.
  // Rx<LocationStatus> get status => Rx(_status);
  Rx<LocationStatus> status = Rx<LocationStatus>(LocationStatus.unknown);

  /// Initializes and starts location tracking.
  Future<void> start() async {
    try {
      status.value = LocationStatus.initialized;

      bool isRunning = await _backgroundService.isRunning();
      if (!isRunning) {
        await _backgroundService.startService();
      }
      await Geolocator.getCurrentPosition();
      status.value = LocationStatus.running;
      status.refresh();
      _backgroundService.on('position').listen(
        (event) {
          distanceCm = 0;
          if (event != null && event['distance'] != null) {
            distanceCm = double.tryParse("${event['distance']}");
          }
          status.refresh();
        },
      );
    } catch (e) {
      //
    }
  }

  /// Stops location tracking and removes any persistent notifications.
  Future<void> stop() async {
    try {
      _backgroundService.invoke("stopService");
      status.value = LocationStatus.stopped;
      status.refresh();
      // Cancel the tracking notification.
      await _notificationsPlugin.cancel(888);
    } catch (e) {
      //
    }
  }

  /// Gets the current location once.
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  /// Prepares and configures the background service.
}

Future<void> initializeBackService() async {
  final FlutterBackgroundService backgroundService = FlutterBackgroundService();

  /// Provides access to local notifications.
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const channel = AndroidNotificationChannel(
    'my_foreground',
    'Location Tracking Service',
    description: 'This service tracks location in the background.',
    importance: Importance.low,
  );

  // Initialize local notifications.
  await notificationsPlugin.initialize(
    const InitializationSettings(
      iOS: DarwinInitializationSettings(),
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  // Create the notification channel on Android.
  await notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Configure the background service.
  await backgroundService.configure(
    androidConfiguration: AndroidConfiguration(
      // Entrypoint for Android when the service starts.
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Location Service',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
      foregroundServiceTypes: [AndroidForegroundType.location],
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      // Entrypoint for iOS when running in the foreground.
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

/// Background task entrypoint for iOS.
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Get.putAsync(() => MyServices().init());
  Get.put(CrudTrans());
  runLocationStream(service);
  return true;
}

/// Background task entrypoint for both iOS (foreground) and Android.
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  // Android specific event listeners.
  if (service is AndroidServiceInstance) {
    service
        .on('setAsForeground')
        .listen((_) => service.setAsForegroundService());
    service
        .on('setAsBackground')
        .listen((_) => service.setAsBackgroundService());
  }

  // Stopping service.
  service.on('stopService').listen((_) {
    service.stopSelf();
  });

  //
  await Get.putAsync(() => MyServices().init());
  Get.put(CrudTrans());

  runLocationStream(service);
}

@pragma('vm:entry-point')
void runLocationStream(ServiceInstance service) async {
  if (!Get.isRegistered<CallbackLocationData>()) {
    Get.put(CallbackLocationData());
  }
  final CallbackLocationData callbackLocationData =
      Get.find<CallbackLocationData>();
  try {
    // On Android, set the service to run in the foreground.
    if (service is AndroidServiceInstance) {
      service.setAsForegroundService();
    }
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 0),
    ).listen((Position position) async {
      double distance = await callbackLocationData.getDistance(position) / 100;
      service.invoke("position", {
        "lat": position.latitude,
        "long": position.longitude,
        "position": position,
        "distance": distance,
      });
      try {
        await callbackLocationData.getData(position, service);
        debugPrint("📍 موقع جديد: ${position.latitude}, ${position.longitude}");
      } catch (e) {
        debugPrint("⚠️ خطأ أثناء تتبع الموقع: $e");
      }
    });
    // Begin tracking.
  } catch (e) {
    debugPrint("⚠️ خطأ $e");
    runLocationStream(service);
  }
}
