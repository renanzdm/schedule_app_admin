class UserModel {
  final String name;
  final String phone;
  final int id;

  const UserModel({
    required this.name,
    required this.phone,
    required this.id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        id: map['id'] ?? -1);
  }
}
