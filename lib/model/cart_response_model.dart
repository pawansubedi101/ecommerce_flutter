class CartResponseModel {
  CartResponseModel({
    required this.data,
  });

  final Data? data;

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      success: json["success"],
      message: json["message"],
    );
  }
}
