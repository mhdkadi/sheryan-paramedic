import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheryan_paramedic/app/core/models/user_model.dart';

class LocalDataBase {
  Future<void> putUser(User user) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String stringUser = jsonEncode(user.toMap());
    await sharedPreferences.setString("user", stringUser);
  }

  Future<User?> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? stringUser = sharedPreferences.getString("user");
    if (stringUser == null) {
      return null;
    } else {
      User user = User.fromMap(jsonDecode(stringUser));
      return user;
    }
  }

  Future<void> deleteUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove("user");
  }
}
