import 'package:avatar_glow/avatar_glow.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_paramedic/app/core/helpers/data_helper.dart';
import 'package:sheryan_paramedic/app/core/models/order_model.dart';
import 'package:sheryan_paramedic/app/core/services/size_configration.dart';
import 'package:sheryan_paramedic/app/core/theme/colors.dart';
import 'package:sheryan_paramedic/app/core/widgets/elevated_button.dart';
import 'package:sheryan_paramedic/app/core/widgets/widget_state.dart';
import 'package:sheryan_paramedic/app/modules/drawer/main_drawer/main_drawer_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_controller.dart';

part 'bottom_widgets.dart';
part 'top_widgets.dart';

class MainHomeView extends GetView<MainHomeController> {
  const MainHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const MainDrawerView(),
      mainScreen: const MainHomeViewBody(),
      borderRadius: 24.0,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      menuScreenWidth: double.infinity,
      disableDragGesture: true,
      isRtl: true,
      showShadow: true,
      angle: 0,
      menuBackgroundColor: AppColors.background,
      drawerShadowsBackgroundColor: AppColors.secondry,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MainHomeViewBody extends GetView<MainHomeController> {
  const MainHomeViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 130),
        child: AppBar(
          elevation: 0.0,
          toolbarHeight: 130,
          centerTitle: true,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context, controller),
                const SizedBox(height: 10),
                StateBuilder<MainHomeController>(
                    id: "myLocation",
                    disableState: true,
                    initialWidgetState: WidgetState.loaded,
                    builder: (widgetState, controller) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: ElevatedStateButton(
                          widgetState: widgetState,
                          onPressed: () {
                            controller.updateCameraPosition();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(
                            Icons.my_location_rounded,
                            color: AppColors.font,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StateBuilder<MainHomeController>(
        id: "DriverState",
        disableState: true,
        initialWidgetState: WidgetState.loaded,
        builder: (widgetState, controller) {
          switch (DataHelper.driverState) {
            case DriverState.offline:
              return changeDriverStateWidget(
                  context: context,
                  offline: true,
                  onStartPressed: () async {
                    controller.updateUser("online");
                  });
            case DriverState.waitingForRide:
              return changeDriverStateWidget(
                  offline: false,
                  context: context,
                  onStartPressed: () async {
                    controller.updateUser("offline");
                  });
            case DriverState.onRide:
              return goingToUserWidget(
                  order: controller.order!,
                  onStart: () async {},
                  context: context,
                  controller: controller);
            default:
              return SizedBox(
                child: Text(DataHelper.driverState.name),
              );
          }
        },
      ),
      body: StateBuilder<MainHomeController>(
        id: "GoogleMapState",
        disableState: true,
        initialWidgetState: WidgetState.loaded,
        builder: (widgetState, controller) {
          return GoogleMap(
            trafficEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            polylines: {
              Polyline(
                polylineId: const PolylineId("value"),
                points: controller.polylinePoints,
                color: AppColors.path,
              )
            },
            markers: controller.markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
            initialCameraPosition: CameraPosition(
              zoom: 12,
              target: DataHelper.currentLocation,
            ),
            onCameraMove: (position) {},
            onMapCreated: (mapController) {
              controller.mapController = mapController;
              controller.setMapStyle(mapController, context);
            },
          );
        },
      ),
    );
  }
}

enum DriverState {
  offline,
  waitingForRide,
  onRide,
}
