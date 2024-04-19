class UserModel {
  final String id;
  final int isverified;
  final String? phone;

  UserModel({
    required this.id,
    required this.isverified,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        isverified: json["isverified"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isverified": isverified,
        "phone": phone,
      };
  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'isverified': isverified,
      'phone': phone,
    };
  }
}
