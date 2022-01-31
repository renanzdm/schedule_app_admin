import 'package:schedule_app_admin/app/service/external_error_service.dart';

abstract class Failure {
  final Object? error;
  final StackTrace? stackTrace;
  final String? message;
  Failure({this.message, 
    this.error,
    this.stackTrace,
  });
}

class UnknownError extends Failure {
  UnknownError(
      {Object? error,
      StackTrace? stackTrace,
      String message = 'Aconteceu um erro no servidor, estaremos investigando'})
      : super(error: error, stackTrace: stackTrace,message: message) {
    if (stackTrace != null) {
      ExternalErrorService.createErrorReport(
          error: error ?? Exception('Error'), stackTrace: stackTrace);
    }
  }
}
