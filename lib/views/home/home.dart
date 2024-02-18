import 'package:ecommerce/components/custom_drawer.dart';
import 'package:ecommerce/components/shopping_cart_badge.dart';
import 'package:ecommerce/utils/app_size.dart';
import 'package:ecommerce/utils/app_strings.dart';
import 'package:ecommerce/views/home/sections/category_section.dart';
import 'package:ecommerce/views/home/sections/customer_detail_section.dart';
import 'package:ecommerce/views/home/sections/product_section.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: const [
          ShoppingCartBadge(),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.p8),
          child: Column(
            children: [
              CustomerDetailSection(),
              CategorySection(),
              ProductSection(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
