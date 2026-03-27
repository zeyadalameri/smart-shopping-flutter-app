import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/controllers/home_page_controller.dart';
import 'package:smart_shopping_fe/core/class/handing_image_network.dart';
import 'package:smart_shopping_fe/core/constants/app_api_links.dart';
import 'package:smart_shopping_fe/core/constants/app_json_image_assets.dart';
import 'package:smart_shopping_fe/data/model/offer_model.dart';
import '../../../core/functions/subtract_text.dart';

class OffersGrideView extends GetView<HomePageController> {
  const OffersGrideView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (controller) {
      return GridView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: controller.offers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        itemBuilder: (context, index) {
          return HomeOfferCard(
            offer: OfferModel.fromJson(controller.offers[index]),
            onTap: () {
              controller.goToDetailsPage(controller.offers[index]);
            },
          );
        },
      );
    });
  }
}

class HomeOfferCard extends GetView<HomePageController> {
  final OfferModel offer;
  final Function()? onTap;

  const HomeOfferCard({
    super.key,
    required this.offer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offer Image with Hero animation
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: Hero(
                    tag: "${offer.id}_${offer.title}",
                    child: HandingImageNetwork(
                      height: 120,
                      width: double.infinity,
                      // : BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      imageUrl:
                          "${offer.images.isNotEmpty ? offer.images.first.imageUrl : AppApiLinks.serverImageError}",

                      errorText: "Error loading image",
                    ),
                  ),
                ),
                // Discount Badge
                if (offer.discount != null && offer.discount! > 0)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${offer.discount!.toStringAsFixed(0)}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Lottie.asset(AppJasonImageAsset.discountOrange,
                              width: 30,
                              height: 30,
                              repeat: false,
                              fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Offer Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Offer Title
                    Text(
                      subtractText(offer.title),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // const SizedBox(height: 8),
                    // Offer Description
                    Text(
                      subtractText(offer.description, maxLength: 50),
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // const SizedBox(height: 8),

                    // Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Old Price (Strikethrough)
                        if (offer.discount != null && offer.discount! > 0)
                          Text(
                            "\$${offer.price}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black,
                              decorationThickness: 2,
                            ),
                          ),

                        // New Price
                        Text(
                          "\$${offer.priceAfterDiscount!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    // const SizedBox(height: 5),

                    // Action Buttons (Favorite + Cart)

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (offer.category!.name ?? ""),
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        // Favorite Button (Can be updated to handle logic)
                        GetBuilder<FavoritesPageController>(
                            builder: (controller) {
                          return IconButton(
                            onPressed: () {
                              controller.checkIfFavoriete(offer.id ?? 0)
                                  ? controller.removeFromFavorite(offer)
                                  : controller.addToFavorite(offer);
                            },
                            icon: Icon(
                              controller.checkIfFavoriete(offer.id ?? 0)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.redAccent,
                            ),
                          );
                        }),

                        // Add to Cart Button
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
