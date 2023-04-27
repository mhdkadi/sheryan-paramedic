import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheryan_paramedic/app/modules/home/home_controller.dart';
import 'package:sheryan_paramedic/app/modules/home/widgets/offline.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const MainDrawerView(),
      mainScreen: const HomeBody(),
      borderRadius: 24.0,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      menuScreenWidth: double.infinity,
      disableDragGesture: true,
      isRtl: false,
      showShadow: true,
      angle: 0,
      menuBackgroundColor: Colors.white,
      drawerShadowsBackgroundColor: Colors.blue,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MainDrawerView extends GetView<HomeController> {
  const MainDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "MainDrawerView",
        builder: (controller) {
          return Container(
            color: Colors.blue,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 150,
                        child: ListView(
                          children: [
                            drawerItem(
                              icon: Icons.person,
                              title: "الملف الشخصي",
                              route: "/ParamedicProfile",
                              context: context,
                            ),
                            drawerItem(
                              icon: Icons.notifications,
                              title: "الإشعارات",
                              route: "/NotificatoinsView",
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget drawerItem({
    required IconData icon,
    required String title,
    required String route,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
        ),
        onPressed: () async {
          Get.toNamed(route);
          ZoomDrawer.of(context)?.close();
        },
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(36.203366909949224, 37.132103341171906),
          zoom: 15,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<HomeController>(
        id: "floatingActionButton",
        builder: (controller) {
          switch (controller.paramedicState) {
            case ParamedicState.offline:
              return const OfflineWidget();
            case ParamedicState.online:
              return const Text("online");
            case ParamedicState.working:
              return const Text("working");
          }
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue),
          ),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(
                Icons.dehaze,
                color: Colors.white,
              ),
              onPressed: () async {
                ZoomDrawer.of(context)?.open();
              },
              iconSize: 25,
            ),
          ),
        ),
        const SizedBox()
      ],
    );
  }
}
