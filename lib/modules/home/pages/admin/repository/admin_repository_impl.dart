import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/custom_hasura/custom_hasura.dart';
import 'package:schedule_app_admin/app/custom_hasura/hasura_queries.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/modules/home/errors/admin_errors.dart';
import 'package:schedule_app_admin/modules/home/models/return_types.dart';

import 'admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final CustomHasuraConnect _hasuraConnect;

  AdminRepositoryImpl({required CustomHasuraConnect hasuraConnect})
      : _hasuraConnect = hasuraConnect;

  @override
  Future<ResultInsertNewTimes> insertNewTimes({required String time}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.insertNewTimes, variables: {
        'time': time,
      });
      if (response['data']['insert_app_times']['affected_rows'] != 0) {
        return right(true);
      } else {
        return left(ErrorInsertNewTimes());
      }
    } catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultDeleteTimes> deleteTime({required int id}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.deleteTimes, variables: {
        'id': id,
      });
      if (response['data']['delete_app_times']['affected_rows'] != 0) {
        return right(true);
      } else {
        return left(ErrorOnDeleteTime());
      }
    } on HasuraError catch (e) {
      return left(ForeignKeyConflict());
    } catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultAddNewVacancy> addNewVacancy(
      {required String date,
      required int idHour,
      required int qtdVacancy}) async {
    try {
      var responseForQtdVacancy = await _hasuraConnect.getConnect.query(
          ScheduleQueries.checkIfAddNewVacancy,
          variables: {'date': date, 'id_hour': idHour});
      var qtdSchedulesOfHourDate =
          (responseForQtdVacancy['data']['app_schedules'] as List).length;
      if (qtdSchedulesOfHourDate > qtdVacancy) {
        return left(NotIsPossibleEditThisConfig());
      } else {
        var response = await _hasuraConnect.getConnect.query(
            ScheduleQueries.getConfigsPerDateAndHour,
            variables: {'date': date, 'id_hour': idHour});
        List listOfConfigsPerDateAndHour =
            response['data']?['app_configuration_day_scheduler'] ?? [];
        if (listOfConfigsPerDateAndHour.isEmpty) {
          //inserir
          var response = await _hasuraConnect.getConnect
              .mutation(ScheduleQueries.insertNewQtdSchedules, variables: {
            'date': date,
            'id_hour': idHour,
            'qtd_of_scheduler': qtdVacancy
          });
          if (response['data']['insert_app_configuration_day_scheduler']
                  ['affected_rows'] !=
              0) {
            return right(true);
          } else {
            return left(NotIsPossibleInsertNewConfiguration());
          }
        } else {
          //fazer update
          var response = await _hasuraConnect.getConnect
              .mutation(ScheduleQueries.updateQtdConfigDay, variables: {
            'id_config': listOfConfigsPerDateAndHour.first['id'],
            'qtd_of_scheduler': qtdVacancy
          });
          if (response['data']['update_app_configuration_day_scheduler']
                  ['affected_rows'] !=
              0) {
            return right(true);
          } else {
            return left(NotIsPossibleInsertNewConfiguration());
          }
        }
      }
    } catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultDeleteConfig> deleteConfigById({required int id}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.deleteConfigPerId, variables: {
        'id': id,
      });
      if (response['data']['delete_app_configuration_day_scheduler']
              ['affected_rows'] !=
          0) {
        return right(true);
      } else {
        return left(NotIsPossibleDeletConfig());
      }
    }catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultInsertNewServices> insertNewServices(
      {required String name,
      required String description,
      required int price}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.insertNewServices, variables: {
        'name': name,
        'description': description,
        'price': price,
      });
      if (response['data']['insert_app_services']['affected_rows'] != 0) {
        return right(true);
      } else {
        return left(NotIsPossibleInsertNewService());
      }
    }  catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultDeleteConfig> deleteServiceById({required int id}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.deleteServices, variables: {
        'id': id,
      });
      if (response['data']['delete_app_services']['affected_rows'] != 0) {
        return right(true);
      } else {
        return left(NotIsPossibleInsertDeleteService());
      }
    } catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultAllSchedules> getAllSchedules() async {
    try {
      Snapshot snapshot = await _hasuraConnect.getConnect
          .subscription(ScheduleQueries.allScheduleSubscription);
      return right(snapshot);
    } catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }

  @override
  Future<ResultDeleteSchedule> deleteSchedule({required int id}) async {
    try {
      var response = await _hasuraConnect.getConnect
          .mutation(ScheduleQueries.deleteSchedule, variables: {
        'id': id,
      });
      if (response['data']['delete_app_schedules']['affected_rows'] != 0) {
        return right(true);
      } else {
        return left(ErrorOnDeleteSchedules());
      }
    } catch (e, s) {
      return left(UnknownError(error: e, stackTrace: s));
    }
  }
}
