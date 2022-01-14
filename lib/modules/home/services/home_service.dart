import 'package:schedule_app_admin/modules/home/pages/schedule/repositories/schedule_repository.dart';

abstract class HomeService{
  Future<ResultGetServices> getServices();
  Future<ResultGetTimeFreeOnDaySelected> getTimes();
  Future<ResultGetSchedulesByDate> getScheduleByDate({required DateTime date});


}