import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrossRoad {
  final String id;
  final List<Marker> trafficLites;
  final Marker center;
  final String address;
  DateTime lastUpdate = DateTime.now();
  final int updateRate = Random().nextInt(20) + 10;
  CrossRoad({
    required this.id,
    required this.trafficLites,
    required this.center,
    required this.address,
  });

  factory CrossRoad.fromMap(Map<String, dynamic> json) => CrossRoad(
        id: json["_id"],
        trafficLites: List<Marker>.from(json["trafficLites"].map(
          (x) => Marker(
            markerId: MarkerId("${json["_id"]}${x["lat"]}"),
            position: LatLng(x["lat"], x["lng"]),
          ),
        )),
        center: Marker(
          markerId: MarkerId(json["_id"]),
          position: LatLng(json["center"]["coordinates"][1],
              json["center"]["coordinates"][0]),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
        address: json["address"],
      );
  static List<CrossRoad> crossRoads(List data) =>
      data.map((e) => CrossRoad.fromMap(e)).toList();
}
