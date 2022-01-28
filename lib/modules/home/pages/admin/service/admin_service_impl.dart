import 'package:schedule_app_admin/modules/home/models/return_types.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository_impl.dart';

import 'admin_service.dart';

class AdminServiceImpl implements AdminService {
  final AdminRepositoryImpl _adminRepositoryImpl;

  AdminServiceImpl({required AdminRepositoryImpl adminRepositoryImpl})
      : _adminRepositoryImpl = adminRepositoryImpl;

  @override
  Future<ResultInsertNewTimes> insertNewTimes({required String time}) async =>
      await _adminRepositoryImpl.insertNewTimes(time: time);

  @override
  Future<ResultDeleteTimes> deleteTime({required int id}) async =>
      await _adminRepositoryImpl.deleteTime(id: id);

  @override
  Future<ResultAddNewVacancy> addNewVacancy(
          {required String date,
          required int idHour,
          required int qtdVacancy}) async =>
      await _adminRepositoryImpl.addNewVacancy(
          date: date, idHour: idHour, qtdVacancy: qtdVacancy);

  @override
  Future<ResultDeleteConfig> deleteConfigById({required int id}) async =>
      await _adminRepositoryImpl.deleteConfigById(id: id);

  @override
  Future<ResultInsertNewServices> insertNewServices(
          {required String name,
          required String description,
          required int price}) async =>
      _adminRepositoryImpl.insertNewServices(
          name: name, description: description, price: price);

  @override
  Future<ResultDeleteConfig> deleteServiceById({required int id}) async =>
      await _adminRepositoryImpl.deleteServiceById(id: id);

  @override
  Future<ResultAllSchedules> getAllSchedules() async =>
      await _adminRepositoryImpl.getAllSchedules();

  @override
  Future<ResultDeleteSchedule> deleteSchedule({required int id}) async =>
      await _adminRepositoryImpl.deleteSchedule(id: id);
}
