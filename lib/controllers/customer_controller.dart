import 'package:ecommerce/model/customer_model.dart';
import 'package:ecommerce/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  var customer = CustomerModel(data: null).obs;
  var isLoading = false.obs;

  Future getCustomerDetails() async {
    try {
      isLoading(true);

      var data = await CustomerService.getCustomerDetails();
      if (data != null) {
        customer.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
