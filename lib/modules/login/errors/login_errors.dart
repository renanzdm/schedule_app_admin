class LoginErrors implements Exception {
  final String error;

  LoginErrors({required this.error});
}

class EmailOrPasswordIncorrect extends LoginErrors {
  EmailOrPasswordIncorrect({required String error}) : super(error: error);
}

class GoogleSignInError extends LoginErrors{
  GoogleSignInError({required String error}):super(error: error);
}
class FacebookSignInError extends LoginErrors{
  FacebookSignInError({required String error}):super(error: error);
}

class UnknownErrorOnLogin extends LoginErrors{
  UnknownErrorOnLogin({required String error}) : super(error: error);

}
