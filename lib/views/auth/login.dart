// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/components/app_logo.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/customer_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/app_controllers.dart';
import 'package:ecommerce/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppLogo(),
            const SizedBox(height: 20),
            const LoginForm(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Register button pressed
              },
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                // skip button pressed
                Get.offNamed(AppRoute.home);
              },
              child: const Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    var cartController = Get.find<CartController>();
    var customerController = Get.find<CustomerController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: AppControllers.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: AppControllers.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, perform login
                      // You can add your login logic here

                      Map data = {
                        'email': AppControllers.emailController.text,
                        'password': AppControllers.passwordController.text,
                      };
                      AppControllers.emailController.clear();
                      AppControllers.passwordController.clear();

                      Loader.show(context,
                          progressIndicator: const CircularProgressIndicator());
                      await authController.login(data);
                      Loader.hide();
                      if (authController.loginMessage.value.data?.token !=
                          null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('token',
                            "${authController.loginMessage.value.data?.token}");
                        customerController.getCustomerDetails();
                        cartController.getCartItems();
                        Get.offNamed(AppRoute.home);
                      } else {
                        Get.defaultDialog(
                            title: "Error",
                            cancel: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Cencel")),
                            content: const Text("Invalid credentials"));
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
