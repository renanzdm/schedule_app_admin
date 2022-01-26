
import '../models/return_types.dart';

abstract class HomeRepository{



  Future<ResultGetServices> getServices();

  Future<ResultGetTimeFreeOnDaySelected> getTimes();

  Future<ResultGetSchedulesByDate> getScheduleByDate({required String date});

  Future<ResultConfigurationDayScheduler> getConfigurationDaySelected(
      {required String date});
  Future<ResultInsertSchedule> createSchedule(
      {required String nameClient,
        required String dateSchedule,
        required int serviceId,
        required int idHour,
        required int idUser});

}