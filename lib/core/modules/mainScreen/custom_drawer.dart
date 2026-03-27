import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/modules/mainscreen_controller.dart';
import 'package:smart_shopping_fe/core/functions/format_distance.dart';
import 'package:smart_shopping_fe/core/localization/controller/locale_controller.dart';
import 'package:smart_shopping_fe/core/localization/langs/translation.dart';
import 'package:smart_shopping_fe/core/services/location/location_service.dart';
import 'custom_user_profile.dart';

class CustomDrawer extends GetView<MainscreenController> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomUserProfile(),
            Column(
              children: List.generate(
                  controller.drower.length,
                  (index) => DrowerButton(
                        data: SelectionButtonData(
                          activeIcon: controller.drower[index]["Active_icon"],
                          icon: controller.drower[index]["icon"],
                          label: "${controller.drower[index]["title"]}".tr,
                        ),
                        onPressed: () {
                          controller.drower[index]["onTap"]() ?? () {};
                        },
                      )),
            ),
            const Divider(thickness: 0),
            GetBuilder<LcaleController>(builder: (controller) {
              return DropdownButton<Locale>(
                value: controller.language, // Track the selected language
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    controller.changeLocale(newLocale);
                  }
                },
                items: controller.appLanguages
                    .map((e) => DropdownMenuItem<Locale>(
                          value: e['locale'],
                          child: Text(e['name']),
                        ))
                    .toList(),
              );
            }),
            const Divider(thickness: 0),
            GetBuilder<LocationService>(builder: (controller) {
              return Row(
                children: [
                  Builder(builder: (context) {
                    return IconButton(
                        onPressed: () {
                          (controller.status.value == LocationStatus.running)
                              ? controller.stop()
                              : controller.start();
                        },
                        icon: Icon(
                          (controller.status.value == LocationStatus.running)
                              ? Icons.location_on_outlined
                              : Icons.location_off_outlined,
                        ));
                  }),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      // Use Obx (or GetBuilder) to rebuild the UI whenever lastLocation changes
                      child: Obx(() {
                        // final location = controller.lastLocation.value;

                        if ((controller.status.value !=
                            LocationStatus.running)) {
                          return Text(Translate.noLocation.tr);
                        } else {
                          // Display latitude and longitude
                          return Text(
                              '${Translate.distance.tr}: ${formatDistance((controller.distanceCm))}');
                        }
                      }),
                    ),
                  ),
                ],
              );
            }),
            //////////
            // Divider(),
            // ElevatedButton(
            //   child: const Text("Background Mode"),
            //   onPressed: () =>
            //       FlutterBackgroundService().invoke("setAsBackground"),
            // ),
          ],
        ),
      ),
    );
  }
}

class DrowerButton extends StatelessWidget {
  const DrowerButton({
    super.key,
    required this.data,
    required this.onPressed,
  });

  final SelectionButtonData data;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    const double appSpacing = 30;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(appSpacing),
        child: Row(
          children: [
            // _icon(context,,
            Icon(
              data.icon,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: appSpacing / 2),
            Expanded(
                child: Text(
              data.label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
                letterSpacing: .8,
                fontSize: 13,
              ),
            )),
            if (data.totalNotif != null)
              Padding(
                padding: const EdgeInsets.only(left: appSpacing / 2),
                child: (data.totalNotif! <= 0)
                    ? Container()
                    : Container(
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          (data.totalNotif! >= 100)
                              ? "99+"
                              : "${data.totalNotif!}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              )
          ],
        ),
      ),
    );
  }
}

class SelectionButtonData {
  final IconData activeIcon;

  final IconData icon;

  final String label;

  final int? totalNotif;
  SelectionButtonData({
    required this.activeIcon,
    required this.icon,
    required this.label,
    this.totalNotif,
  });
}
