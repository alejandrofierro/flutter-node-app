import 'dart:convert';

class Customer {
  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.rating,
  });

  int? id;
  String name;
  String phone;
  String email;
  double rating;

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      rating: json["rating"].toDouble());

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "rating": rating
      };

  Customer copy() => Customer(
      id: this.id,
      name: this.name,
      phone: this.phone,
      email: this.email,
      rating: this.rating);
}
