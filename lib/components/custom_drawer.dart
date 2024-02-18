// ignore_for_file: avoid_print

import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/model/cart_response_model.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    var cartController = Get.find<CartController>();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(0),
              child: Container(
                color: Colors.blue,
              )),
          ListTile(
              onTap: () async {
                Get.defaultDialog(
                    content: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Are you sure you want to logout ?"),
                    ),
                    cancel: ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("Cancel")),
                    confirm: ElevatedButton.icon(
                        onPressed: () async {
                          Get.back();
                          Loader.show(context,
                              progressIndicator:
                                  const CircularProgressIndicator());
                          await authController.logout();
                          Loader.hide();
                          if (authController.logoutMessage.value.success ==
                              true) {
                            cartController.cart.value =
                                CartResponseModel(data: null);
                            Get.snackbar(
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                "Success",
                                authController.logoutMessage.value.message!);

                            await Get.offAllNamed(AppRoute.login);
                          } else {
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                "Error",
                                "Something went wrong !");
                          }
                        },
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text("Logout")));
              },
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}
