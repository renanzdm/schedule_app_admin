import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/errors/schedule_errors.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/configuration_day_scheduler.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/times_model.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ClientHttp _clientHttp;

  ScheduleRepositoryImpl({required ClientHttp clientHttp})
      : _clientHttp = clientHttp;

  @override
  Future<ResultInsertSchedule> createSchedule(
      {required String nameClient,
      required DateTime dateSchedule,
      required int serviceId,
      required int idHour,
      required String idUser}) async {
    try {
  
      var response = await _clientHttp.post('/schedule/createSchedule', data: {
        'name_client': nameClient,
        'date_schedule': '${dateSchedule.year}-${dateSchedule.month}-${dateSchedule.day}',
        'id_hour': idHour,
        'service_id': serviceId,
        'id_user': idUser
      });
      bool result = response.data['data'] ?? false;
      if (result) {
        return right(true);
      } else {
        return left(ScheduleNotPossible());
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return left(ScheduleUnknownError());
    }
  }

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

  @override
  Future<ResultConfigurationDayScheduler> getConfigurationDayScheduler(
      {required DateTime date}) async {
    try {
 
      var response = await _clientHttp.post('/schedule/configDaySheduler',
          data: {'date': '${date.year}-${date.month}-${date.day}'});
      var listOfDayScheduler = response.data['data'] as List;
      if (listOfDayScheduler.isNotEmpty) {
        return right(listOfDayScheduler
            .map((e) => ConfigurationDayScheduler.fromJson(e))
            .toList());
      } else {
        return right([]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return left(ScheduleUnknownError());
    }
  }
}
