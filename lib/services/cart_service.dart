import 'package:dio/dio.dart';
import 'package:ecommerce/model/cart_items_model.dart';
import 'package:ecommerce/model/cart_response_model.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static Future addToCart(Map cartData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await Api.dio.post('cart',
          data: cartData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        return CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connectino Closed.");
    }
  }

  static Future getCartItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await Api.dio.get('cart',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        return CartItemsModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connection Closed.");
    }
  }

  static Future deleteCartItem(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await Api.dio.delete('cart/$id',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        return CartResponseModel.fromJson(response.data);
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
