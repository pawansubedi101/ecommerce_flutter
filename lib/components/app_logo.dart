import 'package:ecommerce/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppStrings.appLogo, // Path to your sample logo image
      width: 150,
      height: 150,
      // You can adjust the width and height according to your logo size
    );
  }
}
