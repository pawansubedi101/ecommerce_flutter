import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ecommerce/utils/app_strings.dart';

class Api {
  static final Dio dio = Dio(BaseOptions(baseUrl: AppStrings.baseUrl, headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  }));

  static void setup() {
    // Add the pretty logger interceptor
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      // requestHeader: true,
    ));
  }
}
