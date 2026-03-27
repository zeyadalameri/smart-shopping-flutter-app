import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/offer_details_page_controller.dart';
import 'package:smart_shopping_fe/core/shared/my_app_bar.dart';
import 'package:smart_shopping_fe/views/widgets/offerDetailsPage/view_details.dart';
import 'package:smart_shopping_fe/views/widgets/offerDetailsPage/view_images.dart';
import '../widgets/offerDetailsPage/offer_location.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    OfferDetailsPageController controller =
        Get.put(OfferDetailsPageController());
    return Scaffold(
      appBar: MyAppBar(title: '${controller.offer.title}'),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: const [
              ImageCards(),
              ViewDetails(),
              OfferLocation(),
            ],
          )),
    );
  }
}
