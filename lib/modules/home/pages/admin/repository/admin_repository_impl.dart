import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';

import 'admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final ClientHttp _clientHttp;

  AdminRepositoryImpl({required ClientHttp clientHttp})
      : _clientHttp = clientHttp;

  @override
  Future<ResultInsertNewTimes> insertNewTimes({required String time}) async {
    try {
      var response =
          await _clientHttp.post('/schedule/insertTimes', data: {'time': time});
      int? statusCode = response.data['code'];
      switch (statusCode) {
        case 200:
          return right(response.data['data']);
        default:
          return right(response.data['data']);
      }
    } catch (e) {
      log(e.toString());

      return left(Exception(e.toString()));
    }
  }

  @override
  Future<ResultDeleteTimes> deleteTime({required int id}) async {
    try {
      var response =
          await _clientHttp.delete('/schedule/deleteTime', data: {'id': id});
      int? statusCode = response.data['code'];
      switch (statusCode) {
        case 200:
          return right(response.data['data']);
        default:
          return right(response.data['data']);
      }
    } catch (e) {
      log(e.toString());
      return left(Exception(e.toString()));
    }
  }
}
