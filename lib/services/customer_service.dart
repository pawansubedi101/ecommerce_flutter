import 'package:dio/dio.dart';
import 'package:ecommerce/model/customer_model.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService {
  static Future getCustomerDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await Api.dio.get('customer',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        return CustomerModel.fromJson(response.data);
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
