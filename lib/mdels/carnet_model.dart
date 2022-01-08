
class CarnetModel {
  CarnetModel({
    this.id,
    required this.fullName,
    required this.dni,
    required this.url,
  });

  int? id;
  String fullName;
  String dni;
  String url;

  factory CarnetModel.fromJson(Map<String, dynamic> json) => CarnetModel(
    id: json["id"] ?? 0,
    fullName: json["fullName"],
    dni: json["dni"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "dni": dni,
    "url": url,
  };
}