import 'package:ecommerce/controllers/customer_controller.dart';
import 'package:ecommerce/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailSection extends StatelessWidget {
  const CustomerDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    var customerController = Get.find<CustomerController>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 5000),
      width: double.infinity,
      // color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(AppSize.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Welcome back\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: "${customerController.customer.value.data?.name}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
