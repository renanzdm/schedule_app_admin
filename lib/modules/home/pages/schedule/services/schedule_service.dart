import '../repositories/schedule_repository.dart';


abstract class ScheduleService {
  Future<ResultInsertSchedule> createSchedule(
    {required String nameClient,required  DateTime dateSchedule,required  int serviceId,required int idHour,required String idUser}
  );
    Future<ResultGetServices> getServices();
      Future<ResultGetSchedulesByDate> getScheduleByDate({required DateTime date});
        Future<ResultConfigurationDayScheduler> getConfigurationDayScheduler({required DateTime date});


}