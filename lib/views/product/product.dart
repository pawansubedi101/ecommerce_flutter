// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/components/shopping_cart_badge.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    var cartController = Get.find<CartController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product View"),
          actions: const [
            ShoppingCartBadge(),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Obx(
          () {
            if (productController.isLoading.value == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              ProductModel product =
                  ProductModel(data: productController.product.value.data);
              return Padding(
                padding: const EdgeInsets.all(AppSize.p8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(product.data!.name!),
                      Image.network(product.data!.image!),
                      product.data!.discount == true
                          ? Text(
                              product.data!.price!.toString(),
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            )
                          : const SizedBox(),
                      if (product.data!.description != 'N/A' &&
                          product.data!.description != null)
                        Text(product.data!.description!),
                      Text(product.data!.sellingPrice!.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          productController.count < 1
                              ? const SizedBox()
                              : IconButton(
                                  onPressed: productController.count < 1
                                      ? null
                                      : () {
                                          productController.remove();
                                        },
                                  icon: const Icon(Icons.remove_circle)),
                          productController.count < 1
                              ? const SizedBox()
                              : Text("${productController.count.value}"),
                          IconButton(
                              onPressed: () {
                                productController.add();
                              },
                              icon: const Icon(Icons.add_circle))
                        ],
                      ),
                      productController.count < 1
                          ? const SizedBox()
                          : ElevatedButton.icon(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var token = prefs.getString("token");
                                if (token == null) {
                                  Get.offNamed(AppRoute.login);
                                } else {
                                  // Add to cart code goes here.
                                  Map cartData = {
                                    "product_id": productController
                                        .product.value.data!.id,
                                    "qty": productController.count.value,
                                    "price": productController
                                        .product.value.data!.sellingPrice
                                  };
                                  Loader.show(context,
                                      progressIndicator:
                                          const CircularProgressIndicator());
                                  await cartController.addToCart(cartData);
                                  Loader.hide();
                                  if (cartController.cart.value.data?.success ==
                                      true) {
                                    Get.snackbar(
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        "Success",
                                        cartController
                                            .cart.value.data!.message!);
                                    productController.count.value = 0;
                                    await cartController.getCartItems();
                                  } else {
                                    Get.snackbar(
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        "Error",
                                        "Something went wrong !");
                                  }
                                }
                              },
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text("Add to cart"),
                            )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
