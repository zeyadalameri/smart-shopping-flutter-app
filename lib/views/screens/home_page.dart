import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/home_page_controller.dart';
import 'package:smart_shopping_fe/core/class/handlingdataview.dart';
import 'package:smart_shopping_fe/core/class/no_data_card.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/views/widgets/homePage/list_offer_categories.dart';
import 'package:smart_shopping_fe/views/widgets/homePage/market_pageview.dart';
import 'package:smart_shopping_fe/views/widgets/homePage/offers_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());

    return RefreshIndicator(
      onRefresh: () async {
        return Future.delayed(
            Duration(seconds: 3), () => controller.onRefreshPage());
      },
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GetBuilder<HomePageController>(builder: (controller) {
              return Row(
                children: [
                  SizedBox(
                    width: Get.mediaQuery.size.width / 2,
                    child: ListOfferCategories(
                      data: controller.tapCategories,
                      selectedIndex: controller.selectedTapIndex,
                      onTap: (index) {
                        controller.onChangeTap(index);
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: (controller.selectedTapIndex == 1)
                        ? HandlingDataView(
                            statusRequest: controller.callBackStatusRequest,
                            child: Text(''))
                        : Text(''),
                  ),
                ],
              );
            }),
          ),
          GetBuilder<HomePageController>(builder: (controller) {
            return HandlingDataView(
              onOfflineShowChild: true,
              statusRequest: controller.marketsStatusRequest,
              child: Column(
                children: [
                  MarketPageview(),
                  ListOfferCategories(
                    data: controller.categories,
                    selectedIndex: controller.selectedCategoryIndex,
                    onTap: (index) {
                      controller.offersPageController.jumpToPage(index);
                    },
                  ),
                  SizedBox(
                    height: (Get.mediaQuery.size.height / 3) * 2,
                    // margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GetBuilder<HomePageController>(
                      builder: (controller) {
                        return controller.categories.isEmpty ||
                                controller.offers.isEmpty
                            ? NoDataCard(text: Translate.noData.tr)
                            : PageView.builder(
                                controller: controller.offersPageController,
                                onPageChanged: (index) {
                                  controller.onCategoryChanges(index);
                                },
                                itemCount: controller.categories.length,
                                itemBuilder: (context, index) {
                                  return const OffersGrideView();
                                },
                              );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
          // SizedBox(height: 50)
        ],
      ),
    );
  }
}
