import 'package:ecommerce/bindings/cart_binding.dart';
import 'package:ecommerce/bindings/order_binding.dart';
import 'package:ecommerce/bindings/product_binding.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/views/auth/login.dart';
import 'package:ecommerce/views/auth/register.dart';
import 'package:ecommerce/views/cart/cart.dart';
import 'package:ecommerce/views/checkout/checkout.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:ecommerce/views/product/product.dart';
import 'package:ecommerce/views/profile/profile.dart';
import 'package:ecommerce/views/splash.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoute.splash,
        page: () => const SplashView(),
        bindings: [CartBindings()]),
    GetPage(
      name: AppRoute.login,
      page: () => const LoginView(),
    ),
    GetPage(name: AppRoute.register, page: () => const RegisterView()),
    GetPage(name: AppRoute.home, page: () => const HomeView(), bindings: [
      ProductBingings(),
    ]),
    GetPage(
      name: AppRoute.cart,
      page: () => const CartView(),
    ),
    GetPage(name: AppRoute.profile, page: () => const ProfileView()),
    GetPage(
        name: AppRoute.checkout,
        page: () => const CheckoutView(),
        binding: OrderBinding()),
    GetPage(name: AppRoute.product, page: () => const ProductView(), bindings: [
      CartBindings(),
    ]),
  ];
}
