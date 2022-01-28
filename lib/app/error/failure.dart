import 'package:flutter/foundation.dart';
import 'package:schedule_app_admin/app/service/external_error_service.dart';

abstract class Failure {
  final Object? error;
  final StackTrace? stackTrace;
  Failure({
    this.error,
    this.stackTrace,
  });
}
class UnknownError extends Failure {
  UnknownError({Object? error, StackTrace? stackTrace})
      : super(error: error, stackTrace: stackTrace) {
    if (stackTrace != null&&!kDebugMode) {
      ExternalErrorService.createErrorReport(
          error: error ?? Exception('Error'), stackTrace: stackTrace);
    }
  }
}
