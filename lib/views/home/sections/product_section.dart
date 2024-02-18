import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return Obx(() {
      if (productController.isLoading.value == true) {
        return const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("Loading..."),
            ],
          ),
        );
      } else {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: productController.products.value.data.length,
          itemBuilder: (context, index) {
            var product = productController.products.value.data[index];
            return GestureDetector(
              onTap: () {
                productController.getProduct(product.id!);
                Get.toNamed(AppRoute.product);
              },
              child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Image.network(
                          product.image.toString(),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Chip(label: Text(product.name.toString())),
                      Text("Rs. ${product.price}")
                    ],
                  )),
            );
          },
        );
      }
    });
  }
}
