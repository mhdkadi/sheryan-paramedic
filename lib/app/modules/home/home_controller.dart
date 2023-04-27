import 'package:get/get.dart';

class HomeController extends GetxController {
  ParamedicState paramedicState = ParamedicState.offline;
}

enum ParamedicState { offline, online, working }
