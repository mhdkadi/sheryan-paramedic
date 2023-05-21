import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sheryan_paramedic/app/core/models/user_model.dart';
import 'package:sheryan_paramedic/app/modules/home/main_home/home_view.dart';

class DataHelper {
  static late PackageInfo packageInfo;
  static DriverState driverState = DriverState.offline;
  static User? user;
  static void reset() {
    user = null;
    driverState = DriverState.offline;
    currentLocation = const LatLng(
      36,
      36,
    );
  }

  static LatLng currentLocation = const LatLng(
    36,
    36,
  );
}
