import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:smart_shopping_fe/core/constants/app_image_assets.dart';
import 'package:smart_shopping_fe/core/localization/controller/locale_controller.dart';

class CustomUserProfile extends StatelessWidget {
  const CustomUserProfile({
    // required this.data,
    // required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: AppBar().preferredSize.height * 1.5),
              GetBuilder<LcaleController>(builder: (controller) {
                return IconButton(
                    onPressed: () {
                      controller.changeTheme();
                    },
                    icon: Icon(
                      controller.isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: Colors.white,
                    ));
              }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(AppImageAsset.logo),
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _TitleText('Smart Shopping'),
                          // _TitleText('desc'),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.data);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onPrimary,
        letterSpacing: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
