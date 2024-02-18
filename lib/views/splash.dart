import 'dart:async';

import 'package:ecommerce/components/app_logo.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/customer_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var cartController = Get.find<CartController>();
  var customerController = Get.find<CustomerController>();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  checkAuth() {
    Timer(const Duration(seconds: 4), () {
      checkToken();
    });
  }

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(
      'token',
    );
    if (token != null) {
      await customerController.getCustomerDetails();
      await cartController.getCartItems();
      Get.offNamed(AppRoute.home);
    } else {
      Get.offNamed(AppRoute.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Your logo image widget goes here
              AppLogo(),
              SizedBox(height: 20),
              CircularProgressIndicator(), // Or any other loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
