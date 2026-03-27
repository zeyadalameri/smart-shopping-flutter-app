import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/controllers/offer_details_page_controller.dart';
import 'package:smart_shopping_fe/core/functions/format_distance.dart';
import 'package:smart_shopping_fe/core/functions/format_status.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';

class ViewDetails extends GetView<OfferDetailsPageController> {
  const ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = controller.offer;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                offer.title ?? Translate.noTitle.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                offer.description ?? 'N/A',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // color: Colors.grey.shade800,
                    ),
              ),

              const Divider(height: 32, thickness: 1),

              // Price + Discount
              _DetailRow(
                icon: Icons.attach_money,
                label: Translate.price.tr,
                value: offer.price == null ? 'N/A' : '\$${offer.price}',
                // valueColor: Colors.black,
              ),

              _DetailRow(
                icon: Icons.discount_outlined,
                label: Translate.discount.tr,
                value: offer.discount == null ? 'N/A' : '${offer.discount}%',
                valueColor: Colors.red.shade700,
              ),
              _DetailRow(
                icon: Icons.attach_money,
                label: Translate.priceAfterDiscount.tr,
                value: (offer.price == null || offer.discount == null)
                    ? 'N/A'
                    // : '\$${((offer.price ?? 0) * (1 - (offer.discount ?? 0) / 100)).toStringAsFixed(2)}',
                    : '\$${offer.priceAfterDiscount!.toStringAsFixed(2)}',
                valueColor: Colors.green,
              ),

              const Divider(height: 32, thickness: 1),

              // Category
              _DetailRow(
                icon: Icons.category_outlined,
                label: Translate.category.tr,
                value: offer.category?.name ?? 'N/A',
              ),

              // Store
              _DetailRow(
                icon: Icons.store_mall_directory_outlined,
                label: Translate.store.tr,
                value: offer.market?.name ?? 'N/A',
              ),

              // Status
              _DetailRow(
                icon: Icons.info_outline,
                label: Translate.status.tr,
                value: formatStatus(offer.status).tr,
              ),

              _DetailRow(
                icon: Icons.pin_drop_outlined,
                label: Translate.address.tr,
                value: "${offer.market?.address}",
              ),

              _DetailRow(
                icon: Icons.route_rounded,
                label: Translate.distance.tr,
                value: formatDistance(offer.market?.distance),
              ),

              const SizedBox(height: 30),

              // Example Button (optional)
              GetBuilder<FavoritesPageController>(builder: (controller) {
                bool isFavorite = controller.checkIfFavoriete(offer.id ?? 0);
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      isFavorite
                          ? controller.removeFromFavorite(offer)
                          : controller.addToFavorite(offer);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red[600] : null,
                    ),
                    label: Text(isFavorite
                        ? Translate.removeFavorite.tr
                        : Translate.addFavorite.tr),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small reusable widget to display a row of icon + label + value.
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: valueColor),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
