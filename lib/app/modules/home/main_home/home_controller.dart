import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_paramedic/app/core/helpers/data_helper.dart';
import 'package:sheryan_paramedic/app/core/models/pathological_case_model.dart';
import 'package:sheryan_paramedic/app/core/repositories/constants_repository.dart';
import 'package:sheryan_paramedic/app/core/repositories/user_repository.dart';
import 'package:sheryan_paramedic/app/core/services/location_service.dart';
import 'package:sheryan_paramedic/app/core/services/notifications/firebase_cloud_messaging.dart';
import 'package:sheryan_paramedic/app/core/services/request_mixin.dart';
import 'package:sheryan_paramedic/app/modules/home/main_home/home_view.dart';

import '../../../core/services/getx_state_controller.dart';

class MainHomeController extends GetxStateController
    with GetSingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  final ConstantsRepository constantsRepository;
  final UserRepository userRepository;
  List<PathologicalCase> pathologicalCases = [];
  MainHomeController({
    required this.constantsRepository,
    required this.userRepository,
  });
  @override
  void onInit() {
    NotificationService.instance.initializeNotifications();
    updateCameraPosition();
    super.onInit();
  }

  void setMapStyle(GoogleMapController controller, BuildContext context) async {
    final String style = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/map_style.json");
    controller.setMapStyle(style);
  }

  Future<void> updateUser(String status) async {
    await requestMethod(
      ids: ["changeDriverStateWidget"],
      stateLessIds: ["DriverState"],
      requestType: RequestType.getData,
      function: () async {
        LatLng currentLocation =
            await LocationService.instance.getCurrentLocation();
        await userRepository.updateUser(
            userId: DataHelper.user!.id,
            status: status,
            currentLocation: currentLocation);
        if (status == "online") {
          DataHelper.driverState = DriverState.waitingForRide;
        } else {
          DataHelper.driverState = DriverState.offline;
        }
        return null;
      },
    );
  }

  LatLng? currentLocation;
  Future<void> updateCameraPosition() async {
    await requestMethod(
      ids: ["myLocation"],
      requestType: RequestType.getData,
      function: () async {
        currentLocation = await LocationService.instance.getCurrentLocation();
        mapController
            ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: currentLocation!,
          zoom: 15,
        )));
        return null;
      },
    );
  }
}
