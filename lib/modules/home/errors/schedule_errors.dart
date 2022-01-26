class ScheduleErrors implements Exception {
  final String error;

  ScheduleErrors(this.error);
}

class ScheduleListServicesIsEmpty extends ScheduleErrors {
  ScheduleListServicesIsEmpty({String error = 'Lista de Servicos esta vazia'})
      : super(error);
}

class ScheduleUnknownError extends ScheduleErrors {
  ScheduleUnknownError({String error = 'Erro desconhecido no servidor'})
      : super(error);
}

class SchedulingIsNotPossible extends ScheduleErrors {
  SchedulingIsNotPossible(
      {String error = 'Nao foi possivel realizar o agendamento do servico'})
      : super(error);
}

class ScheduleListTimeIsEmpty extends ScheduleErrors {
  ScheduleListTimeIsEmpty(
      {String error = 'Nao foi possivel carregar os horarios disponiveis'})
      : super(error);
}
class ScheduleListIsEmpty extends ScheduleErrors {
  ScheduleListIsEmpty(
      {String error = 'Nao foi possivel carregar os horarios disponiveis'})
      : super(error);
}
