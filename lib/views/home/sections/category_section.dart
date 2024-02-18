import 'package:ecommerce/controllers/category_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    var productController = Get.find<ProductController>();
    return Obx(() {
      if (categoryController.isLoading.value == true) {
        return const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("Loading..."),
            ],
          ),
        );
      } else {
        return SizedBox(
          height: 60,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.categories.value.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var category = categoryController.categories.value.data[index];
              return Padding(
                padding: const EdgeInsets.all(AppSize.p8),
                child: GestureDetector(
                    onTap: () {
                      productController.getProductsbyCategory(category.id!);
                    },
                    child: Chip(label: Text(category.name.toString()))),
              );
            },
          ),
        );
      }
    });
  }
}
