import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/core/class/handing_image_network.dart';
import 'package:smart_shopping_fe/core/functions/subtract_text.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/data/model/offer_images_model.dart';
import 'package:smart_shopping_fe/data/model/offer_model.dart';

class FavoriteOfferCard extends GetView<FavoritesPageController> {
  final OfferModel offer;
  final Function()? onTap;
  const FavoriteOfferCard({
    super.key,
    required this.offer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    OfferImagesModel? image = offer.images.first;

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offer Image with Hero animation
            Hero(
                tag: "${image.id}_${image.imageUrl}",
                child: HandingImageNetwork(
                    width: 140,
                    height: 120,
                    imageUrl: "${image.imageUrl}",
                    errorText: 'errorText')),
            // Offer Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Offer Title
                    Text(
                      offer.title ?? Translate.noTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Offer Description
                    Text(
                      subtractText(offer.description ?? '', maxLength: 50),
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (offer.discount != null && offer.discount! > 0)
                              Text(
                                "${offer.price}\$",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              "${((offer.price ?? 0) * (1 - (offer.discount ?? 0) / 100)).toStringAsFixed(2)}\$",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Favorite (Remove) Button
                        IconButton(
                          onPressed: () {
                            controller.removeFromFavorite(offer);
                          },
                          icon: const Icon(Icons.favorite, color: Colors.red),
                        ),
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
