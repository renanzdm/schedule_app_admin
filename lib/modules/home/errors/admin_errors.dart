class AdminErrors implements Exception {
  final String error;
  final String message;

  AdminErrors(this.error, this.message);
}

class ForeignKeyConflict extends AdminErrors {
  ForeignKeyConflict(
      {String error = 'Não é possivel apagar',
      String message = 'Este valoe é usado, por isso não e possível altera-lo'})
      : super(error, message);
}


class UnknownError extends AdminErrors {
  UnknownError(
      {String error = 'Erro desconhecido',
        String message = 'Ocorreu um erro no servidor tente novamente em instantes'})
      : super(error, message);
}
