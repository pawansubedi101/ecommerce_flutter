import 'package:ecommerce/bindings/cart_binding.dart';
import 'package:ecommerce/routes/app_pages.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:ecommerce/utils/app_strings.dart';
import 'package:ecommerce/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Api.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: AppRoute.splash,
      initialBinding: CartBindings(),
      getPages: AppPages.pages,
      home: const SplashView(),
    );
  }
}
