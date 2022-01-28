import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/custom_hasura/hasura_interceptors/logs_interceptors.dart';

import 'hasura_interceptors/hasura_token_interceptor.dart';

class CustomHasuraConnect {
  final String _contentType;

  CustomHasuraConnect() : _contentType = 'application/json';

  HasuraConnect get getConnect {
    return HasuraConnect(
     const String.fromEnvironment('HASURAURL'),
      headers: {
        "content-type": _contentType, 
      },
      interceptors: [
        HasuraTokenInterceptor(),
        LogsInterceptor()],
    );
  }
}