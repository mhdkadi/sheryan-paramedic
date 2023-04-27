import 'package:flutter/material.dart';

class ParamedicProfile extends StatelessWidget {
  const ParamedicProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("ملف الشخصي للمسعف"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            const SizedBox(height: 30),
            Image.asset(
              "assets/images/ambulance.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "اسم المستخدم",
                  style: TextStyle(fontSize: 17),
                ),
                hintText: "**********",
              ),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "رقم الهاتف",
                  style: TextStyle(fontSize: 17),
                ),
                hintText: "********** ",
              ),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "كلمة المرور",
                  style: TextStyle(fontSize: 17),
                ),
                hintText: "********** ",
              ),
            ),
            /////////////////////////////////////////////////////////////////////////////////
            Row(
              children: const [Text("Forgot your password ?")],
            ),
            const SizedBox(height: 50),

            const Center(
              child: Text(
                "هل متأكد من تسجيل الخروج ?",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 17,
            ),

            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "نعم",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "لا",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "تسجيل خروج",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
