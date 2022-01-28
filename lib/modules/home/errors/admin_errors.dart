

import 'package:schedule_app_admin/app/error/failure.dart';

class ForeignKeyConflict extends Failure {

  ForeignKeyConflict(
      {String error = 'Não é possivel apagar',
      String message = 'Este valoe é usado, por isso não e possível altera-lo'})
      : super(error:error);
}


