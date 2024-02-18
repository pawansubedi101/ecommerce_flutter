import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Order"),
        actions: [
          Text("${cartController.cartItems.value.data.length} items."),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Obx(() {
        if (cartController.isLoading.value == true) {
          return const Text("Loading.........");
        } else {
          return ListView.builder(
            itemCount: cartController.cartItems.value.data.length,
            itemBuilder: (context, index) {
              var cartItem = cartController.cartItems.value.data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Container(
                          color: Colors.white,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.network("${cartItem.image}"),
                          )),
                      title: Text("${cartItem.product}"),
                      subtitle: Text(
                          "(${cartItem.qty}) x ${cartItem.price} = ${cartItem.amount}"),
                      trailing: CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  content: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        "Are you sure you want to delete this item ?"),
                                  ),
                                  cancel: ElevatedButton.icon(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(Icons.close),
                                      label: const Text("Cancel")),
                                  confirm: ElevatedButton.icon(
                                      onPressed: () async {
                                        Get.back();
                                        Loader.show(context,
                                            progressIndicator:
                                                const CircularProgressIndicator());
                                        await cartController
                                            .deleteCartItem(cartItem.id!);
                                        Loader.hide();
                                        if (cartController
                                                .cart.value.data?.success ==
                                            true) {
                                          Get.snackbar(
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white,
                                              "Success",
                                              cartController
                                                  .cart.value.data!.message!);

                                          await cartController.getCartItems();
                                        } else {
                                          Get.snackbar(
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              "Error",
                                              "Something went wrong !");
                                        }
                                      },
                                      icon: const Icon(Icons.done),
                                      label: const Text("Delete")));
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        if (cartController.isLoading.value == true) {
          return const Text("Total : Calculating.........");
        } else {
          return Card(
              color: Colors.green,
              margin: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.p16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${cartController.total.value}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              Get.toNamed(AppRoute.checkout);
                            },
                            icon: const Icon(Icons.shopping_cart_checkout),
                            label: const Text("Checkout")),
                      ],
                    ),
                  ],
                ),
              ));
        }
      }),
    );
  }
}
