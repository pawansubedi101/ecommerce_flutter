import 'package:ecommerce/controllers/category_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBingings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.put(CategoryController());
  }
}
