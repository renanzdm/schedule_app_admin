
import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository.dart';

abstract class AdminService{
  Future<ResultInsertNewTimes> insertNewTimes({required String time});
  Future<ResultDeleteTimes> deleteTime({required int id });
  Future<ResultAddNewVacancy> addNewVacancy(
      {required String date, required int idHour, required int qtdVacancy});
  Future<ResultDeleteConfig> deleteConfigById({required  int id});
  Future<ResultInsertNewServices> insertNewServices(
      {required String name, required String description, required int price});
  Future<ResultDeleteConfig> deleteServiceById({required int id});
    Future<ResultAllSchedules> getAllSchedules();



}