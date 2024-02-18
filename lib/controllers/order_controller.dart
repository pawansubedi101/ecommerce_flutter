// ignore_for_file: avoid_print

import 'dart:async';

import 'package:ecommerce/model/order_model.dart';
import 'package:ecommerce/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var order = OrderModel(data: null).obs;
  var isLoading = false.obs;

  Future postOrder(Map orderData) async {
    try {
      isLoading(true);

      var data = await OrderService.postOrder(orderData);
      if (data != null) {
        order.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
