import 'package:dio/dio.dart';
import 'package:ecommerce/model/log_out_model.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/model/register_model.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Future login(Map data) async {
    try {
      var response = await Api.dio.post('login', data: data);

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connectino Closed.");
    }
  }

  static Future register(Map data) async {
    try {
      var response = await Api.dio.post('register', data: data);
      if (response.statusCode == 200) {
        return RegisterModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connectino Closed.");
    }
  }

  static Future logout(String token) async {
    try {
      var response = await Api.dio.get('logout',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        return LogoutModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connection Closed.");
    }
  }
}
