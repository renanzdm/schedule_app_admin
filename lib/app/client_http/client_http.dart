import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:schedule_app_admin/app/client_http/interceptors/json_converter_interceptors.dart';

class ClientHttp extends DioForNative {
  ClientHttp() {
    //super.interceptors.add(TokenInterceptor());
    super.interceptors.add(JsonConverterInterceptor());
    if (kDebugMode) {
      super.interceptors.add(LogInterceptor());
    }
  }
  @override
  set options(BaseOptions _options) {
    _options = BaseOptions(
      baseUrl: 'https://server-schedule-api.herokuapp.com',
      connectTimeout: 15000,
      receiveTimeout: 15000,
    );
    super.options = _options;
  }
}
