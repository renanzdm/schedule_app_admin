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

class NotIsPossibleEditThisConfig extends Failure {
    NotIsPossibleEditThisConfig(
      {String message = 'Essa configuração tem mais agendamentos que voce esta colocando',
      String error = 'Não é possível editar'})
      : super(error: error);
}

class NotIsPossibleInsertNewConfiguration extends Failure {
    NotIsPossibleInsertNewConfiguration(
      {String message = 'Não foi possivel adicionar essa nova configuração',
      String error = 'Não é possível Adicionar'})
      : super(error: error);
}

class NotIsPossibleDeletConfig extends Failure {
    NotIsPossibleDeletConfig(
      {String message = 'Não foi possivel apagar essa nova configuração',
      String error = 'Não é possível Apagar'})
      : super(error: error);
}

class NotIsPossibleInsertNewService extends Failure {
    NotIsPossibleInsertNewService(
      {String message = 'Não foi possivel adicionar esse novo serviço',
      String error = 'Não é possível Adicionar'})
      : super(error: error);
}

class NotIsPossibleInsertDeleteService extends Failure {
    NotIsPossibleInsertDeleteService(
      {String message = 'Não foi possivel deletar esse novo serviço',
      String error = 'Não é possível Apagar'})
      : super(error: error);
}

class ErrorOnDeleteSchedules extends Failure {
    ErrorOnDeleteSchedules(
      {String message = 'Não foi possivel apagar esse agendamento',
      String error = 'Erro ao apagar'})
      : super(error: error);
}
