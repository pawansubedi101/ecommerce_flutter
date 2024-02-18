import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:flutter/material.dart';

class ProductService {
  static Future fetchProducts() async {
    try {
      var response = await Api.dio.get("products");
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connection Closed.");
    }
  }

  static Future fetchProductByCategory(int id) async {
    try {
      var response = await Api.dio.get("categories/$id");
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connection Closed.");
    }
  }

  static Future fetchProduct(int id) async {
    try {
      var response = await Api.dio.get("products/$id");
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Sometging went wrong. $e");
    } finally {
      debugPrint("Connection Closed.");
    }
  }
}
