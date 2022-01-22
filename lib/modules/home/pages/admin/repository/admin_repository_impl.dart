import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/custom_hasura/custom_hasura.dart';
import 'package:schedule_app_admin/app/custom_hasura/hasura_queries.dart';
import 'package:schedule_app_admin/modules/home/errors/admin_errors.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';
import 'package:schedule_app_admin/modules/home/models/services_model.dart';

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
        return left(UnknownError());
      }
    } catch (e) {
      return left(UnknownError());
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
        return left(UnknownError());
      }
    } catch (e) {
      return left(ForeignKeyConflict());
    }
  }

  @override
  Future<ResultAddNewVacancy> addNewVacancy(
      {required String date,
      required int idHour,
      required int qtdVacancy}) async {
    try {
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
          return left(UnknownError());
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
          return left(UnknownError());
        }
      }
    } catch (e) {
      log(e.toString());
      return left(ForeignKeyConflict());
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
        return left(UnknownError());
      }
    } catch (e) {
      return left(ForeignKeyConflict());
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
        return left(UnknownError());
      }
    } catch (e) {
      return left(UnknownError());
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
        return left(UnknownError());
      }
    } catch (e) {
      return left(ForeignKeyConflict());
    }
  }

  @override
  Future<ResultAllSchedules> getAllSchedules() async {
    try {
      Snapshot snapshot = await _hasuraConnect.getConnect
          .subscription(ScheduleQueries.allScheduleSubscription);
      return right(snapshot);

    } catch (e) {
      return left(ForeignKeyConflict());
    }
  }
}
