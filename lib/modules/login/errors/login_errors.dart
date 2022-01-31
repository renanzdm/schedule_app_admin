import 'package:schedule_app_admin/app/error/failure.dart';

class EmailOrPasswordIncorrect extends Failure {
  EmailOrPasswordIncorrect(
      {String message = 'Seu login esta incorreto',
      String error = 'Não é possível se logar'})
      : super(error: error,message: message);
}
