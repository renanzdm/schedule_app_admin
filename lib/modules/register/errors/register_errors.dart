class RegisterErrors implements Exception {
  String? error;
  RegisterErrors({required this.error});
}

class RegisterFailed extends RegisterErrors {
  RegisterFailed({required String error}) : super(error: error);
}

