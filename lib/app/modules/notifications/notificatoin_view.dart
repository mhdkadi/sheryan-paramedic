import 'package:flutter/material.dart';

class NotificatoinsView extends StatelessWidget {
  const NotificatoinsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 30),
            Image.asset(
              "assets/images/ambulance.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.notification_add,
                size: 40,
              ),
              title: const Text(
                " New Notification",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: const Text(" new notification from admin to paramedic"),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.notification_add,
                size: 40,
              ),
              title: const Text(
                " New Notification",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: const Text(" new notification from admin to paramedic"),
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.notification_add,
                size: 40,
              ),
              title: const Text(
                " New Notification",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: const Text(" new notification from admin to paramedic"),
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.notification_add,
                size: 40,
              ),
              title: const Text(
                " New Notification",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: const Text(" new notification from admin to paramedic"),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "View more..........",
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
