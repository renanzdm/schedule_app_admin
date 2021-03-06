import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/modules/register/errors/register_errors.dart';

import './register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final ClientHttp _clientHttp;

  RegisterRepositoryImpl({required ClientHttp clientHttp})
      : _clientHttp = clientHttp;

  @override
  Future<RegisterResultResponse> registerUser({
    required String email,
    required String password,
    String? rule = 'admin',
    required String name,
    required String phone,
  }) async {
    try {
      var response = await _clientHttp.post('/auth/register', data: {
        'email': email,
        'password': password,
        'name': name,
        'rule': rule,
        'phone': phone
      });
      int? statusCode = response.data['code'];
      switch (statusCode) {
        case 200:
          return right(response.data['data']);
        case 403:
          return left(RegisterFailed(error: response.data['data']));
        default:
         return left(RegisterFailed(error: response.data['data']));
      }
    } catch (e) {
      return left(UnknownError());
    }
  }
}
