import 'package:ecommerce/components/v_gap.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/customer_controller.dart';
import 'package:ecommerce/controllers/order_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var customerController = Get.find<CustomerController>();
    var cartController = Get.find<CartController>();
    var orderController = Get.find<OrderController>();
    var productController = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Obx(() {
        if (customerController.isLoading.value == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(AppSize.p16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSize.p16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Details",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Row(
                            children: [
                              Text(
                                "Name : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${customerController.customer.value.data?.name}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Email : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${customerController.customer.value.data?.email}"),
                            ],
                          ),
                          const Divider(),
                          const Vgap(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rs. ${cartController.total} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Vgap(),
                        ],
                      ),
                    ),
                  ),
                  const Vgap(),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        Map orderData = {
                          "total": cartController.total.value,
                          "orderLines":
                              cartController.cartItems.value.data.map((item) {
                            return {
                              "product_id": item.id,
                              "qty": item.qty,
                              "amount": item.amount
                            };
                          }).toList()
                        };

                        Loader.show(context,
                            progressIndicator:
                                const CircularProgressIndicator());
                        await orderController.postOrder(orderData);
                        Loader.hide();
                        if (orderController.order.value.data?.success == true) {
                          Get.defaultDialog(
                              backgroundColor: Colors.green.shade300,
                              title: "Ordre",
                              content: Text(
                                  "${orderController.order.value.data?.message}"),
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    productController.count.value = 0;

                                    cartController.getCartItems();
                                    Get.off(AppRoute.home);
                                  },
                                  child: const Text("Ok")));
                        } else {
                          Get.defaultDialog(
                              backgroundColor: Colors.red.shade200,
                              title: "Error",
                              content: Text(
                                  "${orderController.order.value.data?.message}"),
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Ok")));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Place Order",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ))
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
