import 'package:ecommerce/model/categories_model.dart';
import 'package:ecommerce/services/category_service.dart';
import 'package:ecommerce/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categories = CategoriesModel(data: []).obs;
  var isLoading = false.obs;

  Future getCategoriess() async {
    try {
      isLoading(true);

      var data = await CategoryService.fetchCategories();
      if (data != null) {
        categories.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future getProductsByCategory(int id) async {
    try {
      isLoading(true);

      var data = await ProductService.fetchProductByCategory(id);
      if (data != null) {
        categories.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getCategoriess();

    super.onInit();
  }
}
