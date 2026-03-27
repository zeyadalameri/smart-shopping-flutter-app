import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_shopping_fe/controllers/notifications_page_controller.dart';
import 'package:smart_shopping_fe/core/functions/subtract_text.dart';
import 'package:smart_shopping_fe/data/model/notify_model.dart';
import '../../../core/class/handing_image_network.dart';

class NotificationCard extends GetView<NotificationsPageController> {
  final NotifyModel notify;
  final Function()? onTap;
  const NotificationCard({
    super.key,
    required this.notify,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (notify.imageUrl != null)
              Hero(
                  tag: "${notify.id}_${notify.imageUrl}",
                  child: HandingImageNetwork(
                      height: 100,
                      width: 100,
                      filterQuality: FilterQuality.low,
                      imageUrl: "${notify.imageUrl}",
                      errorText: "errorText")),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      notify.title ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtractText(notify.description ?? '', maxLength: 50),
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Favorite (Remove) Button
                        IconButton(
                          onPressed: () {
                            controller.removeFromNotifications(notify);
                          },
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
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
