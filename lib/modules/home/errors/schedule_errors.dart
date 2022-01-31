import 'package:schedule_app_admin/app/error/failure.dart';

class ListServicesIsEmpty extends Failure {
  ListServicesIsEmpty(
      {String error = 'Lista de Servicos esta vazia',
      String message = 'A lista de serviços está vazia'})
      : super(error: error, message: message);
}

class SchedulingIsNotPossible extends Failure {
  SchedulingIsNotPossible(
      {String error = 'Nao foi possivel concluir o agendamento',
      String message = 'Nao foi possivel realizar o agendamento do servico'})
      : super(error: error, message: message);
}

class ScheduleListTimeIsEmpty extends Failure {
  ScheduleListTimeIsEmpty(
      {String error = 'Não foi possível carregar os agendamentos',
      String message = 'Nao foi possivel carregar os horarios disponiveis'})
      : super(error: error, message: message);
}

class ListTimesIsEmpty extends Failure {
  ListTimesIsEmpty(
      {String error = 'Não foi possível carregar os horários',
      String message = 'Nao foi possivel carregar os horarios disponiveis'})
      : super(error: error, message: message);
}
