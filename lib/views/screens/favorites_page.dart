import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/favorites_page_controller.dart';
import 'package:smart_shopping_fe/core/class/no_data_card.dart';
import 'package:smart_shopping_fe/core/functions/alert_dialog.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/core/shared/my_app_bar.dart';
import 'package:smart_shopping_fe/data/model/market_model.dart';
import 'package:smart_shopping_fe/data/model/offer_model.dart';
import 'package:smart_shopping_fe/views/widgets/favoritesPage/favorite_market_card.dart';
import 'package:smart_shopping_fe/views/widgets/favoritesPage/favorite_offer_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    FavoritesPageController controller = Get.put(FavoritesPageController());
    return DefaultTabController(
      initialIndex: 0,
      length: controller.tapsList.length,
      child: Scaffold(
        appBar: MyAppBar(
          title: Translate.favoritesPage.tr,
          actions: [
            IconButton(
                onPressed: () {
                  myAlertDialog(
                    title: Translate.warning.tr,
                    message: Translate.warning1.tr,
                    onCancel: () {
                      // Get.back();
                    },
                    onConfirm: () {
                      controller.clearAll();
                    },
                  );
                },
                icon: Icon(Icons.delete_sweep_outlined))
          ],
          bottom: TabBar(
            tabs: controller.tapsList
                .map((tab) => Tab(text: "${tab['name']}".tr))
                .toList(),
            // labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            labelStyle: Theme.of(context).textTheme.titleSmall,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  width: 3.0, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        body: GetBuilder<FavoritesPageController>(builder: (controller) {
          return TabBarView(children: <Widget>[
            //

            RefreshIndicator(
              onRefresh: () {
                return controller.onRefresh();
              },
              child: controller.offers.isEmpty
                  ? ListView(
                      children: [
                        Center(child: NoDataCard(text: Translate.noData.tr)),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.offers.length,
                      itemBuilder: (context, index) => FavoriteOfferCard(
                        offer: OfferModel.fromJson(controller.offers[index]),
                        onTap: () {
                          controller.goToDetails(index);
                        },
                      ),
                    ),
            ),

            RefreshIndicator(
              onRefresh: () {
                return controller.onRefresh();
              },
              child: controller.markets.isEmpty
                  ? ListView(
                      children: [
                        NoDataCard(text: Translate.noData.tr),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.markets.length,
                      itemBuilder: (context, index) => FavoriteMarketCard(
                        market: MarketModel.fromJson(controller.markets[index]),
                        onTap: () {
                          controller.goToDetailsMarket(index);
                        },
                      ),
                    ),
            ),
          ]);
        }),
      ),
    );
  }
}
