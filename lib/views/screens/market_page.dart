import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/class/handlingdataview.dart';
import 'package:smart_shopping_fe/core/functions/subtract_text.dart';
import 'package:smart_shopping_fe/views/widgets/marketPage/market_offers_grid_view.dart';
import 'package:smart_shopping_fe/controllers/market_page_controller.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    MarketPageController controller = Get.put(MarketPageController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('${subtractText(controller.market.name)}',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary)),
      ),
      body: GetBuilder<MarketPageController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () {
              return controller.onRefresh();
            },
            child: HandlingDataView(
                onOfflineShowChild: true,
                statusRequest: controller.statusRequest,
                child: const MarketOffersGridView()),
          );
        },
      ),
    );
  }
}
