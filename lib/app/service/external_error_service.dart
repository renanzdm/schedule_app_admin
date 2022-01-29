

import 'dart:isolate';

import 'package:sentry_flutter/sentry_flutter.dart';

class ExternalErrorService {
  static createErrorReport(
      {required Object error, StackTrace? stackTrace}) async {
    await _sendErrorExternal(error, stackTrace);
  }

  static initIsolateOnErrorListener(){
    Isolate.current.addErrorListener(_isolateErrorListener);
  }

  static  SendPort get _isolateErrorListener {
    return RawReceivePort((dynamic error){
      final List<dynamic> errorList = error;
      final exception = errorList[0];
      final stacktrace = errorList[1];
      _sendErrorExternal(exception, stacktrace);
    }).sendPort;
  }


  static Future<void> _sendErrorExternal(
      Object error, StackTrace? stackTrace) async {
    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
    );
  }
}
