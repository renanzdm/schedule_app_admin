import 'package:schedule_app_admin/modules/home/pages/schedule/repositories/schedule_repository.dart';
import 'package:schedule_app_admin/modules/home/repositories/home_repository_impl.dart';
import 'package:schedule_app_admin/modules/home/services/home_service.dart';

class HomeServiceImpl implements HomeService{
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
      {required DateTime date}) async =>
      _homeRepositoryImpl.getScheduleByDate(date: date);
}