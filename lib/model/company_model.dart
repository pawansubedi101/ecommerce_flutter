class CompanyModel {
  CompanyModel({
    required this.data,
  });

  final Data? data;

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.logo,
  });

  final int? id;
  final String? name;
  final String? address;
  final String? contact;
  final String? email;
  final String? logo;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      contact: json["contact"],
      email: json["email"],
      logo: json["logo"],
    );
  }
}
