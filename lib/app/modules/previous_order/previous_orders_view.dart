import 'package:flutter/material.dart';

class PreviousOrders extends StatelessWidget {
  const PreviousOrders({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الطلبات السابقة"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/ambulance.png",
              width: 150,
              height: 150,
            ),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    style: TextStyle(fontSize: 20),
                    'اسم المريض ',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Text(
                  "رقم الهاتف ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 60),
                Text(
                  "الحالة",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 70),
                Text(
                  "العنوان",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "الموقع",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
                "_____________________________________________________________________"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    style: TextStyle(fontSize: 20),
                    'اسم المريض ',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Text(
                  "رقم الهاتف",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 60),
                Text(
                  "الحالة",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 70),
                Text(
                  "العنوان",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
                "_____________________________________________________________________"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    style: TextStyle(fontSize: 20),
                    'Patient Name ',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Text(
                  "NumberPhone",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 60),
                Text(
                  "Stauts",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 70),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
                "_____________________________________________________________________"),
          ],
        ),
      ),
    );
  }
}
