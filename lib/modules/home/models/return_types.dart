import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/modules/home/errors/schedule_errors.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';
import 'package:schedule_app_admin/modules/home/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/models/times_model.dart';

typedef ResultInsertSchedule = Either<ScheduleErrors, bool>;
typedef ResultGetServices = Either<ScheduleErrors, List<ServicesModel>>;
typedef ResultGetTimeFreeOnDaySelected
= Either<ScheduleErrors, List<TimesModel>>;
typedef ResultGetSchedulesByDate = Either<ScheduleErrors, List<SchedulesModel>>;
typedef ResultConfigurationDayScheduler
= Either<ScheduleErrors, List<DateWithConfigModel>>;