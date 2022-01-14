import 'dart:convert';

import 'package:dio/dio.dart';

class JsonConverterInterceptor extends Interceptor{
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.data = jsonDecode(response.data);
    super.onResponse(response, handler);
  }
}