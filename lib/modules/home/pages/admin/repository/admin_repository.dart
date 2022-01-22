import 'package:fpdart/fpdart.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/modules/home/errors/admin_errors.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';

typedef ResultInsertNewTimes = Either<AdminErrors, bool>;
typedef ResultDeleteTimes = Either<AdminErrors, bool>;
typedef ResultAddNewVacancy = Either<AdminErrors, bool>;
typedef ResultDatesWithConfig = Either<AdminErrors, List<DateWithConfigModel>>;
typedef ResultDeleteConfig = Either<AdminErrors, bool>;
typedef ResultInsertNewServices = Either<AdminErrors, bool>;
typedef ResultAllSchedules = Either<AdminErrors, Snapshot>;

abstract class AdminRepository {
  Future<ResultInsertNewTimes> insertNewTimes({required String time});

  Future<ResultDeleteTimes> deleteTime({required int id});

  Future<ResultAddNewVacancy> addNewVacancy(
      {required String date, required int idHour, required int qtdVacancy});



  Future<ResultDeleteConfig> deleteConfigById({required int id});

  Future<ResultInsertNewServices> insertNewServices(
      {required String name, required String description, required int price});
  Future<ResultDeleteConfig> deleteServiceById({required int id});
 
  Future<ResultAllSchedules> getAllSchedules();

}
