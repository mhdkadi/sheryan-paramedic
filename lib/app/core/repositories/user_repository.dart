import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sheryan_paramedic/app/core/models/user_model.dart';
import 'package:sheryan_paramedic/app/core/services/local_database.dart';

class UserRepository {
  final Dio dio;
  final LocalDataBase localDataBase;

  UserRepository({
    required this.dio,
    required this.localDataBase,
  });

  Future<User> login({
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await dio.post(
        "/users/login",
        data: {
          "username": username,
          "password": password,
        },
      );
      log(response.data.toString());
      User user = User.fromMap(response.data);
      await localDataBase.putUser(user);
      return user;
    } catch (e) {
      if (e.runtimeType == DioError) {
        e as DioError;
        if (e.response?.statusCode == 404) {
          throw "المستخدم غير موجود";
        } else {
          throw "حدث خطأ ما";
        }
      } else if (e.runtimeType == SocketException) {
        throw "لايوجد إنترنت";
      } else if (e.runtimeType == FormatException) {
        throw "خطأ في المعلومات";
      } else {
        throw "حدث خطأ ما";
      }
    }
  }

////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<User> register({
    required String username,
    required String password,
    required String address,
    required String phoneNumber,
    required String hospital,
  }) async {
    try {
      final Response response = await dio.post("/users/register", data: {
        "username": username,
        "password": password,
        "address": address,
        "phone": phoneNumber,
        "hospital": hospital,
      });

      log(response.data.toString());

      User user = User.fromMap(response.data);
      await localDataBase.putUser(user);
      return user;
    } catch (e) {
      log(e.toString());

      if (e.runtimeType == DioError) {
        e as DioError;
        if (e.response?.statusCode == 404) {
          throw "يوجد خطأ ما ";
        } else {
          throw "حدث خطأ ما ";
        }
      } else if (e.runtimeType == SocketException) {
        throw "لا يوجد إنترنت";
      } else if (e.runtimeType == FormatException) {
        throw " خطأ في المعلومات ";
      } else {
        throw "حدث خطأ ما ";
      }
    }
  }
}
