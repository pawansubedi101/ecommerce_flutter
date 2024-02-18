import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartBadge extends StatelessWidget {
  const ShoppingCartBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Obx(() => GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.cart);
          },
          child: Badge.count(
            count: cartController.cartItems.value.data.length,
            child: const CircleAvatar(child: Icon(Icons.shopping_cart)),
          ),
        ));
  }
}
