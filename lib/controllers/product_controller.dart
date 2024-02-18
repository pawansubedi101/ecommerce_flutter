import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:ecommerce/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = ProductsModel(data: []).obs;
  var product = ProductModel(data: null).obs;
  var count = 0.obs;
  var isLoading = false.obs;

  Future getProducts() async {
    try {
      isLoading(true);

      var data = await ProductService.fetchProducts();
      if (data != null) {
        products.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future getProductsbyCategory(int id) async {
    try {
      isLoading(true);

      var data = await ProductService.fetchProductByCategory(id);
      if (data != null) {
        products.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future getProduct(int id) async {
    try {
      isLoading(true);

      var data = await ProductService.fetchProduct(id);
      if (data != null) {
        product.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  add() {
    count++;
  }

  remove() {
    count--;
    if (count < 1) {
      count.value = 0;
    }
  }

  @override
  void onInit() {
    getProducts();

    super.onInit();
  }
}
