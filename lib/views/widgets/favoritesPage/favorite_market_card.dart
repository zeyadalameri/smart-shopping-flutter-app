import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/core/class/handing_image_network.dart';
import 'package:smart_shopping_fe/core/functions/subtract_text.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';

class FavoriteMarketCard extends GetView<FavoritesPageController> {
  final MarketModel market;
  final Function()? onTap;
  const FavoriteMarketCard({
    super.key,
    required this.market,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // OfferImagesModel? image = market.images.first;

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
                tag: "${market.id}_${market.imageUrl}",
                child: HandingImageNetwork(
                    width: 140,
                    height: 120,
                    imageUrl: "${market.imageUrl}",
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
                      market.name ?? Translate.noTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Offer Description
                    Text(
                      subtractText(market.description ?? '', maxLength: 50),
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Favorite (Remove) Button
                        IconButton(
                          onPressed: () {
                            controller.removeFromFavoriteMarket(market);
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
