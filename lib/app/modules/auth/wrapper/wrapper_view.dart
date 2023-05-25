import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheryan_paramedic/app/core/theme/colors.dart';

import '../../../core/services/size_configration.dart';
import '../../../core/widgets/widget_state.dart';
import 'wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSizer(builder: (CustomSize customSize) {
        return StateBuilder<WrapperController>(
            id: "WrapperView",
            disableState: true,
            builder: (widgetState, controller) {
              return SizedBox(
                width: customSize.screenWidth,
                child: Column(
                  children: [
                    const Spacer(),
                    const SizedBox(height: 45),
                    const Icon(
                      Icons.screen_lock_portrait_outlined,
                      size: 200,
                      color: AppColors.secondry,
                    ),
                    const SizedBox(height: 20),
                    if (widgetState == WidgetState.error)
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.initWrapper();
                            },
                            child: const Text("إعادة المحاولة")),
                      )
                    else
                      const SizedBox(height: 45),
                    const Spacer(),
                  ],
                ),
              );
            });
      }),
    );
  }
}
