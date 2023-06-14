import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_paramedic/app/core/helpers/data_helper.dart';
import 'package:sheryan_paramedic/app/core/models/cross_road_model.dart';
import 'package:sheryan_paramedic/app/core/models/order_model.dart';
import 'package:sheryan_paramedic/app/core/models/pathological_case_model.dart';
import 'package:sheryan_paramedic/app/core/repositories/constants_repository.dart';
import 'package:sheryan_paramedic/app/core/repositories/user_repository.dart';
import 'package:sheryan_paramedic/app/core/services/location_service.dart';
import 'package:sheryan_paramedic/app/core/services/notifications/firebase_cloud_messaging.dart';
import 'package:sheryan_paramedic/app/core/services/request_mixin.dart';
import 'package:sheryan_paramedic/app/core/utils/distance_between_two_points.dart';
import 'package:sheryan_paramedic/app/modules/home/main_home/home_view.dart';

import '../../../core/services/getx_state_controller.dart';

class MainHomeController extends GetxStateController
    with GetSingleTickerProviderStateMixin {
  Order? order;
  List<LatLng> polylinePoints = [];
  List<CrossRoad> crossRoads = [];
  Set<Marker> markers = {};
  String level = "غير محدد";
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
    getCrossRoads();
    LocationService.instance.onChangeLocaltion((location) {
      currentLocation = LatLng(location.latitude!, location.longitude!);
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setupMarkers();
    });
    super.onInit();
  }

  Future<void> getCrossRoads() async {
    crossRoads = await constantsRepository.getCrossRoads();
    setupMarkers();
  }

  void setupMarkers() {
    markers = {};
    update(["GoogleMapState"]);
    for (int j = 0; j < crossRoads.length; j++) {
      bool pointInsidePolyline = false;

      if (isMarkerNearPolyline(
          crossRoads[j].center.position, polylinePoints, 100)) {
        markers.add(crossRoads[j].center);
        for (int z = 0; z < crossRoads[j].trafficLites.length; z++) {
          if (distanceBetweenTwoPoints(
                      currentLocation, crossRoads[j].trafficLites[z].position) <
                  1000 &&
              isMarkerNearPolyline(
                  crossRoads[j].trafficLites[z].position, polylinePoints, 10)) {
            for (int i = 0; i < crossRoads[j].trafficLites.length; i++) {
              crossRoads[j].trafficLites[i] =
                  crossRoads[j].trafficLites[i].copyWith(
                        iconParam: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed,
                        ),
                      );
            }
            markers.add(crossRoads[j].center.copyWith(
                  iconParam: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                ));
            log(crossRoads[j].trafficLites[z].position.toString());
            crossRoads[j].trafficLites[z] =
                crossRoads[j].trafficLites[z].copyWith(
                      iconParam: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen,
                      ),
                    );
            pointInsidePolyline = true;
            break;
          }
        }
      }
      if (!pointInsidePolyline &&
          DateTime.now().isAfter(crossRoads[j]
              .lastUpdate
              .add(Duration(seconds: crossRoads[j].updateRate)))) {
        for (int i = 0; i < crossRoads[j].trafficLites.length; i++) {
          crossRoads[j].trafficLites[i] =
              crossRoads[j].trafficLites[i].copyWith(
                    iconParam: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed,
                    ),
                  );
        }
        crossRoads[j].lastUpdate = DateTime.now();
        Marker firstMarker = crossRoads[j].trafficLites.first;
        crossRoads[j].trafficLites.add(firstMarker);
        crossRoads[j].trafficLites.removeAt(0);

        crossRoads[j].trafficLites.first =
            crossRoads[j].trafficLites.first.copyWith(
                  iconParam: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                );
      }

      markers.addAll(crossRoads[j].trafficLites);
    }

    update(["GoogleMapState"]);
  }

  void setMapStyle(GoogleMapController controller, BuildContext context) async {
    final String style = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/map_style.json");
    controller.setMapStyle(style);
  }

  Future<void> newOrder(Order order) async {
    this.order = order;
    // order.location = const LatLng(36.21585586071535, 37.115531038040814);
    DataHelper.driverState = DriverState.onRide;
    update(["DriverState", "changeDriverStateWidget"]);
    polylinePoints = await constantsRepository
        .getPloyLine(points: [currentLocation, order.location]);
    setupMarkers();

    update(["GoogleMapState"]);
  }

  Future<void> updateUser(String status) async {
    await requestMethod(
      ids: ["changeDriverStateWidget"],
      stateLessIds: ["DriverState"],
      requestType: RequestType.getData,
      function: () async {
        final String fcmToken =
            await NotificationService.instance.getFcmToken();
        LatLng currentLocation =
            await LocationService.instance.getCurrentLocation();
        await userRepository.updateUser(
          userId: DataHelper.user!.id,
          status: status,
          fcmToken: fcmToken,
          currentLocation: currentLocation,
        );
        if (status == "online") {
          DataHelper.driverState = DriverState.waitingForRide;
        } else {
          DataHelper.driverState = DriverState.offline;
        }
        if (order != null) {
          await newOrder(order!);
        }
        return null;
      },
    );
  }

  LatLng currentLocation = const LatLng(36, 36);
  Future<void> updateCameraPosition() async {
    await requestMethod(
      ids: ["myLocation"],
      requestType: RequestType.getData,
      function: () async {
        currentLocation = await LocationService.instance.getCurrentLocation();
        mapController
            ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: currentLocation,
          zoom: 15,
        )));
        return null;
      },
    );
  }
}
