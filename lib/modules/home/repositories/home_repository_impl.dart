import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/errors/schedule_errors.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/repositories/schedule_repository.dart';
import 'package:schedule_app_admin/modules/home/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final ClientHttp _clientHttp;

  HomeRepositoryImpl({required ClientHttp clientHttp})
      : _clientHttp = clientHttp;
  @override
  Future<ResultGetServices> getServices() async {
    try {
      var response = await _clientHttp.get('/schedule/services');
      var listServices = response.data['data'] as List;
      if (listServices.isNotEmpty) {
        return right(
            listServices.map((e) => ServicesModel.fromMap(e)).toList());
      } else {
        return left(ScheduleListServicesIsEmpty());
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return left(ScheduleUnknownError());
    }
  }

  @override
  Future<ResultGetTimeFreeOnDaySelected> getTimes() async {
    try {
      var response = await _clientHttp.get('/schedule/alltimes');
      var listTimes = response.data['data'] as List;
      if (listTimes.isNotEmpty) {
        return right(listTimes.map((e) => TimesModel.fromMap(e)).toList());
      } else {
        return left(ScheduleListServicesIsEmpty());
      }
    } catch (e) {
      return left(ScheduleUnknownError());
    }
  }

  @override
  Future<ResultGetSchedulesByDate> getScheduleByDate(
      {required DateTime date}) async {
    try {

      var response = await _clientHttp.post('/schedule/scheduleByDate',
          data: {'date': '${date.year}-${date.month}-${date.day}'});
      int? statusCode = response.data['code'];
      switch (statusCode) {
        case 200:
          var listTimes = response.data['data'] as List;
          if (listTimes.isNotEmpty) {
            return right(listTimes.map((e) => SchedulesModel.fromMap(e)).toList());
          } else {
            return right([]);
          }
        case 403:
          return left(ScheduleUnknownError(error: response.data['data']));
        default:
          return left(ScheduleUnknownError(error: 'Erro desconhecido'));
      }




    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return left(ScheduleUnknownError());
    }
  }

}