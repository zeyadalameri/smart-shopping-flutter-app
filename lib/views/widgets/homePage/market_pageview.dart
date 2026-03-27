import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/controllers/home_page_controller.dart';
import 'package:smart_shopping_fe/core/class/handing_image_network.dart';
import 'package:smart_shopping_fe/core/functions/subtract_text.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';

class MarketPageview extends StatelessWidget {
  const MarketPageview({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (controller) {
      return SizedBox(
        height: 250,
        child: PageView.builder(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.onChangeMarket(index);
          },
          itemCount: controller.markets.length,
          itemBuilder: (context, index) {
            bool isSelected = index == controller.selectedMarketIndex;
            double scale = isSelected ? 1 : 1; // Center item is larger

            return Container(
              height: isSelected ? 200 : 100,
              width: isSelected ? 250 : 150,
              margin: EdgeInsets.all(isSelected ? 0 : 5),
              padding: EdgeInsets.all(isSelected ? 0 : 15),
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(begin: scale, end: scale),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: MarketCard(
                      market: MarketModel.fromJson(controller.markets[index]),
                      // isSelected: isCentered,
                      onTap: () {
                        controller.goToMarket(index);
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}

class MarketCard extends GetView<HomePageController> {
  final MarketModel market;
  final Function()? onTap;

  const MarketCard({
    super.key,
    required this.market,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼️ Market Image with Hero Animation
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Hero(
                    tag: "${market.id}_${market.name}",
                    child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: HandingImageNetwork(
                            imageUrl: market.imageUrl ?? '',
                            height: 130,
                            width: double.infinity,
                            errorText: 'errorText')),
                  ),

                  /// ❤️ Favorite Button (Optional)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GetBuilder<FavoritesPageController>(
                        builder: (controller) {
                      return CircleAvatar(
                        backgroundColor: Colors.white.withAlpha(180),
                        child: IconButton(
                          icon: Icon(
                              controller.checkIfFavorieteMarket(market.id ?? 0)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red),
                          onPressed: () {
                            controller.checkIfFavorieteMarket(market.id ?? 0)
                                ? controller.removeFromFavoriteMarket(market)
                                : controller.addToFavoriteMarket(market);
                          },
                        ),
                      );
                    }),
                  ),
                  // Positioned(
                  //   bottom: 1,
                  //   left: 2,
                  //   child:

                  //       /// ⭐ Ratings & Button
                  //       Container(
                  //     color: const Color.fromARGB(123, 0, 0, 0),
                  //     child: Row(
                  //       children: List.generate(
                  //         5,
                  //         (index) => Icon(
                  //           // index < (market.rating ?? 0)
                  //           index < (4) ? Icons.star : Icons.star_border,
                  //           size: 18,
                  //           color: Colors.amber,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            /// 📌 Market Details Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // /// 📌 Market Name
                    Text(
                      market.name ?? 'N/A',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),
                    Text(
                      subtractText(market.description, maxLength: 200),
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),

                    /// 📍 Market Address
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            market.address ?? 'N/A',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
