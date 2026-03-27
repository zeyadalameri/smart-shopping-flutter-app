import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shopping_fe/core/modules/mainscreen_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainscreenController>(
        builder: (controller) => BottomAppBar(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 8,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...List.generate(controller.bottomappbar.length, ((index) {
                  int i = index;
                  return controller.bottomappbar[i]['icon'] == null
                      ? const Text('')
                      : _PhCustomNavButton(
                          textbutton: controller.bottomappbar[i]['title'],
                          icondata: controller.bottomappbar[i]['icon'],
                          onPressed: () {
                            controller.changePage(i);
                          },
                          active: controller.currentpage == i ? true : false);
                }))
              ],
            )));
  }
}

class _PhCustomNavButton extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData? icondata;
  final bool? active;
  const _PhCustomNavButton(
      {required this.textbutton,
      required this.icondata,
      required this.onPressed,
      required this.active});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: AppBar().preferredSize.height,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icondata,
            color: active == true
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).disabledColor),
        Text(textbutton.tr,
            style: TextStyle(
                color: active == true
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).disabledColor))
      ]),
    );
  }
}
