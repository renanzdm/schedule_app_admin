class TokenModel{
 final String accessToken;



  const TokenModel({
    required this.accessToken,
  });


  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      accessToken: map['accessToken'] ??'',
    );
  }

 @override
  String toString() {
    return 'TokenModel{accessToken: $accessToken}';
 }
}