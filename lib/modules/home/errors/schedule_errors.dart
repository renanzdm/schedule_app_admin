

import 'package:schedule_app_admin/app/error/failure.dart';

class ScheduleListServicesIsEmpty extends Failure {
  ScheduleListServicesIsEmpty({String error = 'Lista de Servicos esta vazia'})
      : super(error:error);
}

class ScheduleUnknownError extends Failure {
  ScheduleUnknownError({String error = 'Erro desconhecido no servidor'})
      : super(error:error);
}

class SchedulingIsNotPossible extends Failure {
  SchedulingIsNotPossible(
      {String error = 'Nao foi possivel realizar o agendamento do servico'})
      : super(error:error);
}

class ScheduleListTimeIsEmpty extends Failure {
  ScheduleListTimeIsEmpty(
      {String error = 'Nao foi possivel carregar os horarios disponiveis'})
      : super(error:error);
}
class ScheduleListIsEmpty extends Failure {
  ScheduleListIsEmpty(
      {String error = 'Nao foi possivel carregar os horarios disponiveis'})
      : super(error:error);
}
