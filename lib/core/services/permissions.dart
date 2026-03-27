import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Request a specific permission and handle its status.
  /// Returns [true] if the permission is granted, [false] if denied.
  Future<bool> requestPermission(Permission permission) async {
    // Request the permission and store the result.
    PermissionStatus status = await permission.request();

    // If the permission is denied, handle it accordingly.
    if (status.isDenied) {
      return _handleDeniedPermission(permission);
    }

    // Return whether the permission is granted.
    return status.isGranted;
  }

  /// Request foreground location permission.
  /// Returns [true] if granted, [false] if denied.
  Future<bool> requestLocationPermission() async {
    return await requestPermission(Permission.locationWhenInUse);
  }

  /// Request background location permission.
  /// Returns [true] if granted, [false] if denied.
  Future<bool> requestBackgroundLocationPermission() async {
    return await requestPermission(Permission.locationAlways);
  }

  /// Request notification permission.
  /// Returns [true] if granted, [false] if denied.
  Future<bool> requestNotificationPermission() async {
    return await requestPermission(Permission.notification);
  }

  /// Request permission to ignore battery optimizations.
  /// Returns [true] if granted, [false] if denied.
  Future<bool> requestBatteryOptimizationPermission() async {
    return await requestPermission(Permission.ignoreBatteryOptimizations);
  }

  /// Request all required permissions at once.
  /// Returns [true] if all permissions are granted, [false] if any permission is denied.
  Future<bool> requestAllPermissions() async {
    // Request all required permissions and store the statuses.
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.notification,
      // Permission.locationWhenInUse,
      Permission.ignoreBatteryOptimizations,
      // Permission.locationAlways,
    ].request();

    // Ensure that all permissions are granted.
    return statuses.values.every((status) => status.isGranted);
  }

  /// Request notification permissions using **Awesome Notifications** package.
  /// Ensures permission is granted for sending notifications.
  Future<void> requestNotificationPermissionsWithAwesome() async {
    if (!await AwesomeNotifications().isNotificationAllowed()) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Check if location services are enabled on the device.
  /// Returns [true] if location services are enabled, [false] otherwise.
  Future<bool> isLocationServiceEnabled() async {
    return await Permission.location.serviceStatus.isEnabled;
  }

  /// Handle the scenario when a permission is denied.
  /// If the user has denied permission, show an appropriate rationale or feedback.
  Future<bool> _handleDeniedPermission(Permission permission) async {
    // If the user has denied the permission, check if a rationale is needed.
    if (await permission.shouldShowRequestRationale) {
      // Optionally, you could display a dialog explaining why this permission is required.
      // Example: showRationaleDialog(permission);
      return false;
    }

    // If no rationale is needed, permission will not be requested again unless the user changes their settings manually.
    return false;
  }

  // Optional: A helper method to show rationale dialog (if needed)
  // Future<void> showRationaleDialog(Permission permission) async {
  //   // Implement custom logic for showing a dialog to the user.
  //   // Example: Show a custom dialog explaining why the permission is necessary.
  // }
}
