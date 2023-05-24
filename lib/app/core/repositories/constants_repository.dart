import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_paramedic/app/core/constants/request_routes.dart';
import 'package:sheryan_paramedic/app/core/models/cross_road_model.dart';
import 'package:sheryan_paramedic/app/core/models/notification_model.dart';
import 'package:sheryan_paramedic/app/core/models/order_model.dart';
import 'package:sheryan_paramedic/app/core/models/pathological_case_model.dart';
import 'package:sheryan_paramedic/app/core/utils/exceptions.dart';
import 'package:sheryan_paramedic/app/core/utils/polyline_encoder.dart';

import 'repository_interface.dart';

class ConstantsRepository extends RepositoryInterface {
  Future<void> order({
    required String level,
    required String userId,
    required String pathologicalCase,
    required LatLng currentLocation,
  }) async {
    try {
      await dio.post(
        RequestRoutes.order,
        data: {
          "level": level,
          "status": "toUser",
          "location": {
            "lat": currentLocation.latitude,
            "lng": currentLocation.longitude,
          },
          "user": userId,
          "pathologicalCase": pathologicalCase,
        },
      );
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<PathologicalCase>> pathologicalCases() async {
    try {
      Response response =
          await dio.get(RequestRoutes.pathologicalCases, queryParameters: {
        "page": 0,
        "limit": 100,
      });
      return PathologicalCase.pathologicalCases(
          response.data["pathologicalCases"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<NotificationModel>> getNotifications(
      {required String userId}) async {
    try {
      Response response = await dio.get(
        RequestRoutes.notification,
        queryParameters: {
          "page": 0,
          "limit": 100,
          "user": userId,
        },
      );
      return NotificationModel.notifications(response.data["notifications"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<Order>> getOrders({
    required String userId,
  }) async {
    try {
      Response response = await dio.get(
        RequestRoutes.order,
        queryParameters: {
          "page": 0,
          "limit": 100,
          "user": userId,
        },
      );
      return Order.orders(response.data["orders"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<CrossRoad>> getCrossRoads() async {
    try {
      Response response = await dio.get(
        RequestRoutes.crossroad,
        queryParameters: {
          "page": 0,
          "limit": 1000,
        },
      );
      return CrossRoad.crossRoads(response.data["Crossroads"]);
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  Future<List<LatLng>> getPloyLine({
    required List<LatLng> points,
    bool isToUserPolyline = false,
  }) async {
    try {
      final Response response = await dio.post(
        "https://api.waddini-sy.com/route",
        // "https://api.hala-technology.com/taxi/Api/getPloyLineV2",
        data: {
          "points": [
            [points[0].longitude, points[0].latitude],
            [points[1].longitude, points[1].latitude]
          ]
          // "points": encodeStopPoints(points),
          // 'is_to_user_polyline': isToUserPolyline,
        },
      );
      final List<List<num>> decodedPolyLine =
          decodePolyline(response.data["paths"][0]["points"]);
      final List<LatLng> polylinePoints = <LatLng>[];
      for (int i = 0; i < decodedPolyLine.length; i++) {
        polylinePoints.add(LatLng(decodedPolyLine[i][0].toDouble(),
            decodedPolyLine[i][1].toDouble()));
      }

      return polylinePoints;
    } catch (error) {
      throw ExceptionHandler(error);
    }
  }

  List<Map<String, double>> encodeStopPoints(List<LatLng> points) {
    final List<Map<String, double>> encodedPoints = <Map<String, double>>[];
    for (var point in points) {
      encodedPoints.add({"lat": point.latitude, "lng": point.longitude});
    }
    return encodedPoints;
  }
}
