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
