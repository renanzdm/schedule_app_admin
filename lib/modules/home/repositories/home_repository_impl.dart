import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/custom_hasura/custom_hasura.dart';
import 'package:schedule_app_admin/app/custom_hasura/hasura_queries.dart';
import 'package:schedule_app_admin/modules/home/errors/schedule_errors.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';
import 'package:schedule_app_admin/modules/home/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/repositories/home_repository.dart';

import '../models/return_types.dart';

class HomeRepositoryImpl implements HomeRepository {
  final CustomHasuraConnect _hasuraConnect;

  HomeRepositoryImpl({required CustomHasuraConnect hasuraConnect})
      : _hasuraConnect = hasuraConnect;

  @override
  Future<ResultGetServices> getServices() async {
    try {
      var response =
          await _hasuraConnect.getConnect.query(ScheduleQueries.getServices);
      var listServices = response['data']['app_services'] as List;
      if (listServices.isNotEmpty) {
        return right(
            listServices.map((e) => ServicesModel.fromMap(e)).toList());
      } else {
        return left(ScheduleListServicesIsEmpty(error: 'Lista está vazia'));
      }
    } catch (e) {
      log(e.toString());
      return left(ScheduleUnknownError());
    }
  }

  @override
  Future<ResultGetTimeFreeOnDaySelected> getTimes() async {
    try {
      var response =
          await _hasuraConnect.getConnect.query(ScheduleQueries.getAllTimes);
      var listTimes = response['data']['app_times'] as List;
      if (listTimes.isNotEmpty) {
        return right(listTimes.map((e) => TimesModel.fromMap(e)).toList());
      } else {
        return left(ScheduleListServicesIsEmpty(error: 'Lista está vazia'));
      }
    } catch (e) {
      log(e.toString());
      return left(ScheduleUnknownError());
    }
  }

  @override
  Future<ResultGetSchedulesByDate> getScheduleByDate(
      {required String date}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .query(ScheduleQueries.getSchedulesByDate, variables: {'date': date});
      var listSchedules = response['data']['app_schedules'] as List;
      if (listSchedules.isNotEmpty) {
        return right(listSchedules
            .map<SchedulesModel>((e) => SchedulesModel.fromMap(e))
            .toList());
      } else {
        return left(ScheduleListServicesIsEmpty(error: 'Lista está vazia'));
      }
    } catch (e) {
      log(e.toString());
      return left(ScheduleUnknownError());
    }
  }

  @override
  Future<ResultConfigurationDayScheduler> getConfigurationDaySelected(
      {required String date}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .query(ScheduleQueries.getConfigurationDaySelected, variables: {
        'date': date,
      });
      List listDatesWithConfig =
          response['data']['app_configuration_day_scheduler'];
      if (listDatesWithConfig.isNotEmpty) {
        return right(listDatesWithConfig
            .map<DateWithConfigModel>((e) => DateWithConfigModel.fromMap(e))
            .toList());
      } else {
        return left(ScheduleListServicesIsEmpty(error: 'Lista está vazia'));
      }
    } catch (e) {
      log(e.toString());
      return left(ScheduleUnknownError());
    }
  }

  @override
  Future<ResultInsertSchedule> createSchedule(
      {required String nameClient,
      required String dateSchedule,
      required int serviceId,
      required int idHour,
      required int idUser,
      required String nameService,
      required hour}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.insertSchedule, variables: {
        'name_client': nameClient,
        'date_schedule': dateSchedule,
        'id_hour': idHour,
        'service_id': serviceId,
        'id_user': idUser,
        'name_service': nameService,
        'hour': hour
      });
      if (response['data']['insert_app_schedules']['affected_rows'] >= 1) {
        return right(true);
      } else {
        return left(SchedulingIsNotPossible(
            error: 'Não foi possível criar o agendamento'));
      }
    } catch (e, s) {
      return left(ScheduleUnknownError());
    }
  }
}
