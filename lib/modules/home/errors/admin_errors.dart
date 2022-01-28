import 'package:schedule_app_admin/app/error/failure.dart';

class ForeignKeyConflict extends Failure {
  ForeignKeyConflict(
      {String error = 'Não é possivel apagar',
      String message = 'Este valoe é usado, por isso não e possível altera-lo'})
      : super(error: error);
}

class ErrorInsertNewTimes extends Failure {
    ErrorInsertNewTimes(
      {String message = 'Não foi possivel adicionar novo horario ',
      String error = 'Ocorreu um erro inesperado'})
      : super(error: error);
}

class ErrorOnDeleteTime extends Failure {
    ErrorOnDeleteTime(
      {String message = 'Não foi possivel apagar esse horario ',
      String error = 'Ocorreu um erro inesperado'})
      : super(error: error);
}