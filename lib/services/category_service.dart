import 'package:ecommerce/model/categories_model.dart';
import 'package:ecommerce/utils/api.dart';
import 'package:flutter/material.dart';

class CategoryService {
  static Future fetchCategories() async {
    try {
      var response = await Api.dio.get("categories");
      if (response.statusCode == 200) {
        return CategoriesModel.fromJson(response.data);
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
