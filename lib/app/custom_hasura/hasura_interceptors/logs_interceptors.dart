
import 'dart:developer';
import 'package:hasura_connect/hasura_connect.dart';

class LogsInterceptor extends Interceptor {
  @override
  Future onError(HasuraError? error, HasuraConnect connect) async {
    log(error.toString());
    return error;
  }

  @override
  Future onRequest(Request? request, HasuraConnect connect) async {
    return request;
  }

  @override
  Future onResponse(Response? response, HasuraConnect connect) async {
    return response;
  }

  @override
  Future<void> onSubscription(Request request, Snapshot snapshot) async {}

  @override
  Future<void> onConnected(HasuraConnect connect) async {
    log('📡HASURA CONNECT📡');
  }

  @override
  Future<void> onDisconnected() async {
    log('HASURA DISCONNECTED');
  }

  @override
  Future<void> onTryAgain(HasuraConnect connect) async {
    log('hasura trying reconnect...');
  }
}