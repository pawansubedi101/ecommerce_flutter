import 'package:ecommerce/model/cart_items_model.dart';
import 'package:ecommerce/model/cart_response_model.dart';
import 'package:ecommerce/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = CartResponseModel(data: null).obs;
  var cartItems = CartItemsModel(data: []).obs;
  var total = 0.obs;
  var isLoading = false.obs;

  Future addToCart(Map cartData) async {
    try {
      isLoading(true);

      var data = await CartService.addToCart(cartData);
      if (data != null) {
        cart.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future getCartItems() async {
    try {
      isLoading(true);

      var data = await CartService.getCartItems();
      if (data != null) {
        cartItems.value = data;
        total.value = 0;
        for (var item in cartItems.value.data) {
          total = total + item.amount!;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future deleteCartItem(int id) async {
    try {
      isLoading(true);

      var data = await CartService.deleteCartItem(id);
      if (data != null) {
        cart.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
