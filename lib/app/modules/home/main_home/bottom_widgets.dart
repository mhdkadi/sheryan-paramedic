part of 'home_view.dart';

Widget changeDriverStateWidget({
  required BuildContext context,
  required bool offline,
  required void Function() onStartPressed,
}) {
  return StateBuilder<MainHomeController>(
    id: "changeDriverStateWidget",
    initialWidgetState: WidgetState.loaded,
    disableState: true,
    builder: (widgetState, controller) {
      return AvatarGlow(
        glowColor: widgetState == WidgetState.loading
            ? AppColors.path
            : offline
                ? AppColors.secondry
                : AppColors.red,
        endRadius: 70,
        child: InkWell(
          onTap: widgetState == WidgetState.loading ? null : onStartPressed,
          child: CircleAvatar(
            backgroundColor: widgetState == WidgetState.loading
                ? AppColors.primary
                : offline
                    ? AppColors.secondry
                    : AppColors.font,
            radius: 55,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primary,
                    color: widgetState == WidgetState.loading
                        ? AppColors.path
                        : offline
                            ? AppColors.background
                            : AppColors.red,
                    value: widgetState == WidgetState.loading ? null : 1,
                  ),
                ),
                Text(
                  offline ? "ابدأ" : "توقف",
                  style: TextStyle(
                    color: widgetState == WidgetState.loading
                        ? AppColors.path
                        : offline
                            ? AppColors.background
                            : AppColors.red,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget goingToUserWidget({
  required Order order,
  required Future<void> Function() onStart,
  required BuildContext context,
  required MainHomeController controller,
}) {
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  return DraggableScrollableSheet(
    controller: draggableScrollableController,
    maxChildSize: 0.2,
    minChildSize: 0.12,
    initialChildSize: 0.2,
    builder: (context, scrollController) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: ScreenSizer(
          builder: (customSize) {
            return Container(
              color: AppColors.background,
              width: double.infinity,
              height: 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.font,
                        ),
                        Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: AppColors.font,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: customSize.screenWidth,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: customSize.screenWidth - 250,
                            child: Text(
                              "${order.user.fullName}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: StateBuilder<MainHomeController>(
                                id: "arrivedToMeetingPoint",
                                disableState: true,
                                initialWidgetState: WidgetState.loaded,
                                builder: (widgetState, controller) {
                                  return ElevatedStateButton(
                                    widgetState: widgetState,
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondryBackground,
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Icon(
                                      Icons.notifications,
                                      color: AppColors.path,
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedStateButton(
                              widgetState: WidgetState.loaded,
                              onPressed: () {
                                launchUrl(Uri.parse(
                                    'tel://${order.user.phone.replaceFirst("963", "0")}'));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondryBackground,
                                padding: EdgeInsets.zero,
                              ),
                              child: const Icon(
                                Icons.call,
                                color: AppColors.secondry,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: AppColors.secondryBackground,
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: ListTile(
                    //     leading: const Icon(
                    //       Icons.location_history,
                    //       color: AppColors.secondry,
                    //       size: 35,
                    //     ),
                    //     title: Text(ride.addressFrom),
                    //     subtitle: Text(ride.addressFromDetails),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
