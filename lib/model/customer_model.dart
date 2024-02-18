class CustomerModel {
  CustomerModel({
    required this.data,
  });

  final Data? data;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json["name"],
      email: json["email"],
    );
  }
}
