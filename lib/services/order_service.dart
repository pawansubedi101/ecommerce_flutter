import 'package:dio/dio.dart';
import 'package:ecommerce/model/order_model.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  static Future postOrder(Map cartData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await Api.dio.post('order',
          data: cartData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connectino Closed.");
    }
  }
}
