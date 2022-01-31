import 'package:schedule_app_admin/app/error/failure.dart';

class RegisterFailed extends Failure {
  RegisterFailed(
      {String message = 'Não foi possivel se registrar',
      String error = 'Não é possível Apagar'})
      : super(error: error);
}
