import 'package:schedule_app_admin/modules/home/repositories/home_repository_impl.dart';
import 'package:schedule_app_admin/modules/home/services/home_service.dart';

import '../models/return_types.dart';

class HomeServiceImpl implements HomeService {
  final HomeRepositoryImpl _homeRepositoryImpl;

  HomeServiceImpl({required HomeRepositoryImpl homeRepositoryImpl})
      : _homeRepositoryImpl = homeRepositoryImpl;

  @override
  Future<ResultGetServices> getServices() async =>
      _homeRepositoryImpl.getServices();

  @override
  Future<ResultGetTimeFreeOnDaySelected> getTimes() async =>
      _homeRepositoryImpl.getTimes();

  @override
  Future<ResultGetSchedulesByDate> getScheduleByDate(
          {required String date}) async =>
      _homeRepositoryImpl.getScheduleByDate(date: date);

  @override
  Future<ResultConfigurationDayScheduler> getConfigurationDaySelected(
          {required String date}) async =>
      _homeRepositoryImpl.getConfigurationDaySelected(date: date);
  @override
  Future<ResultInsertSchedule> createSchedule(
          {required String nameClient,
          required String dateSchedule,
          required int serviceId,
          required int idHour,
          required int idUser,
          required String nameService,
          required hour}) async =>
      _homeRepositoryImpl.createSchedule(
          nameClient: nameClient,
          dateSchedule: dateSchedule,
          serviceId: serviceId,
          idHour: idHour,
          idUser: idUser,
          hour: hour,
          nameService: nameService);
}
