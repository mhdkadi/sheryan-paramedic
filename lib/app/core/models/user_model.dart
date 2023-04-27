class User {
  final String id;
  final String address;
  final String phone;
  final String username;
  final String hospital;

  User({
    required this.id,
    required this.address,
    required this.phone,
    required this.username,
    required this.hospital,
  });
  factory User.fromMap(Map data) => User(
        id: data["id"],
        address: data["address"],
        phone: data["phone"],
        username: data["username"],
        hospital: data["hospital"] ?? "unknown",
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "address": address,
      "phone": phone,
      "username": username,
      "hospital": hospital,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
