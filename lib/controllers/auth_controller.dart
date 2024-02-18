// ignore_for_file: avoid_print

import 'dart:async';

import 'package:ecommerce/model/log_out_model.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var loginMessage = LoginModel(data: null).obs;
  var logoutMessage = LogoutModel(message: null, success: null).obs;
  var isLoading = false.obs;

  Future login(Map userData) async {
    try {
      isLoading(true);

      var data = await AuthService.login(userData);
      if (data != null) {
        loginMessage.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future logout() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var data = await AuthService.logout(token!);
      if (data != null) {
        logoutMessage.value = data;
      }
      await prefs.clear();
      print("Going to homepage");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
