import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_shopping_fe/controllers/offer_details_page_controller.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';

// import 'offer_details_page_controller.dart';

class OfferLocation extends GetView<OfferDetailsPageController> {
  const OfferLocation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the coordinates from the Offer's Market
    final double lat = controller.offer.market?.lat ?? 15.432013;
    final double lng = controller.offer.market?.long ?? 44.214206;
    final LatLng location = LatLng(lat, lng);

    return Card(
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            // --- Map Preview ---
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: location,
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('offerLocation'),
                      position: location,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      ),
                      infoWindow: const InfoWindow(title: 'Offer Location'),
                    ),
                  },
                  // Enable Lite Mode on Android to reduce data usage
                  liteModeEnabled: true, // iOS ignores this parameter
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                ),
              ),
            ),
            // --- Button: Go to Map ---
            GetBuilder<OfferDetailsPageController>(builder: (controller) {
              var color = Theme.of(context).colorScheme.secondary;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: () => controller.openExternalMap(lat, lng),
                leading: Icon(Icons.arrow_back, color: color),
                title: Text(
                  Translate.goToMap.tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: color,
                      ),
                ),
                trailing: Icon(Icons.map, color: color),
              );
            }),
          ],
        ),
      ),
    );
  }
}
