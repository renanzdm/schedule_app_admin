
import 'package:sentry_flutter/sentry_flutter.dart';

class ExternalErrorService {
  static createErrorReport(
      {required Object error, StackTrace? stackTrace}) async {
    await _sendErrorExternal(error, stackTrace);
  }


  static Future<void> _sendErrorExternal(
      Object error, StackTrace? stackTrace) async {
    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
    );
  }
}
