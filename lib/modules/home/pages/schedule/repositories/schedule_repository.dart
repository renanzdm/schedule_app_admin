import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/errors/schedule_errors.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/configuration_day_scheduler.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/times_model.dart';

typedef ResultInsertSchedule = Either<ScheduleErrors, bool>;
typedef ResultGetServices = Either<ScheduleErrors, List<ServicesModel>>;
typedef ResultGetTimeFreeOnDaySelected
    = Either<ScheduleErrors, List<TimesModel>>;
typedef ResultGetSchedulesByDate = Either<ScheduleErrors, List<SchedulesModel>>;
typedef ResultConfigurationDayScheduler
    = Either<ScheduleErrors, List<ConfigurationDayScheduler>>;

abstract class ScheduleRepository {
  Future<ResultInsertSchedule> createSchedule(
      {required String nameClient,
      required DateTime dateSchedule,
      required int serviceId,
      required int idHour,
      required int idUser});

  Future<ResultGetServices> getServices();


  Future<ResultGetSchedulesByDate> getScheduleByDate({required DateTime date});

  Future<ResultConfigurationDayScheduler> getConfigurationDayScheduler(
      {required DateTime date});
}
