import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double distanceBetweenTwoPoints(
  LatLng startPoint,
  LatLng endPoint,
) {
  double toRadians(double degree) => degree * pi / 180;
  double earthRadius = 6378137.0;
  double dLat = toRadians(endPoint.latitude - startPoint.latitude);
  double dLon = toRadians(endPoint.longitude - startPoint.longitude);

  double a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) *
          cos(toRadians(startPoint.latitude)) *
          cos(toRadians(endPoint.latitude));
  double c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

bool isPointInsidePolyline(LatLng position, List<LatLng> polylinePoints) {
  var isInside = false;

  for (var i = 0; i < polylinePoints.length - 1; i++) {
    final LatLng startPoint = polylinePoints[i];
    final LatLng endPoint = polylinePoints[i + 1];

    final double distanceToStart = calculateDistance(position, startPoint);
    final double distanceToEnd = calculateDistance(position, endPoint);
    final double segmentDistance = calculateDistance(startPoint, endPoint);

    if (distanceToStart + distanceToEnd <= segmentDistance + 1e-6) {
      isInside = true;
      break;
    }
  }

  return isInside;
}

double calculateDistance(LatLng point1, LatLng point2) {
  const earthRadius = 6371000; // in meters
  final lat1 = point1.latitude * pi / 180;
  final lon1 = point1.longitude * pi / 180;
  final lat2 = point2.latitude * pi / 180;
  final lon2 = point2.longitude * pi / 180;

  final dLat = lat2 - lat1;
  final dLon = lon2 - lon1;

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  final distance = earthRadius * c;
  return distance;
}

bool isMarkerNearPolyline(
    LatLng markerPosition, List<LatLng> polylinePoints, int meters) {
  for (var i = 0; i < polylinePoints.length - 1; i++) {
    final LatLng startPoint = polylinePoints[i];
    final LatLng endPoint = polylinePoints[i + 1];

    final double distance = calculateDistance(markerPosition, startPoint);
    if (distance < meters) {
      return true; // Marker is within meters meters of the polyline
    }

    final double segmentDistance = calculateDistance(startPoint, endPoint);
    if (segmentDistance > 0) {
      final int segmentSteps = (segmentDistance / meters).ceil();

      for (var j = 1; j <= segmentSteps; j++) {
        final double fraction = j / segmentSteps;
        final LatLng intermediatePoint = LatLng(
          startPoint.latitude +
              (endPoint.latitude - startPoint.latitude) * fraction,
          startPoint.longitude +
              (endPoint.longitude - startPoint.longitude) * fraction,
        );

        final double distance =
            calculateDistance(markerPosition, intermediatePoint);
        if (distance < meters) {
          return true; // Marker is within meters meters of the polyline
        }
      }
    }
  }

  return false; // Marker is not within 100 meters of the polyline
}
