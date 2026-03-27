import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/controllers/offer_details_page_controller.dart';
import 'package:smart_shopping_fe/core/class/handing_image_network.dart';
import 'package:smart_shopping_fe/data/model/offer_images_model.dart';

class ImageCards extends StatelessWidget {
  const ImageCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferDetailsPageController>(builder: (controller) {
      return SizedBox(
        height: 300,
        child: PageView.builder(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.onChangeImage(index);
          },
          itemCount: controller.offer.images.length,
          itemBuilder: (context, index) {
            bool isSelected = index == controller.selectedImageIndex;
            double scale = isSelected ? 1 : 1; // Center item is larger

            return Container(
              height: isSelected ? 200 : 100,
              // width: isSelected ? 350 : 150,
              // color: Colors.red,
              margin: EdgeInsets.all(isSelected ? 0 : 15),
              padding: EdgeInsets.all(isSelected ? 0 : 10),
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(begin: scale, end: scale),
                builder: (context, value, child) {
                  return Transform.scale(
                      scale: value,
                      child: ImageCard(image: controller.offer.images[index]));
                },
              ),
            );
          },
        ),
      );
    });
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.image});
  final OfferImagesModel image;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
      height: 300,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 176, 181, 195),
          borderRadius: BorderRadius.circular(25)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Hero(
            tag: "${image.id}_${image.imageUrl}",
            child: HandingImageNetwork(
                height: 140,
                filterQuality: FilterQuality.low,
                imageUrl: "${image.imageUrl}",
                errorText: "errorText")),
      ),
    );
  }
}
