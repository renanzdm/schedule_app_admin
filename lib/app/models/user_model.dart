class UserModel {
  final String name;
  final String phone;
  final int id;
  final String accessToken;

  const UserModel({
    required this.name,
    required this.phone,
    required this.id,
    required this.accessToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        accessToken: map['accessToken'] ??'',
        id: map['id'] ?? -1);
  }
}
