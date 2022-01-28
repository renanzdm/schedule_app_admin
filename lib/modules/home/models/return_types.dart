import 'package:fpdart/fpdart.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';
import 'package:schedule_app_admin/modules/home/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/models/times_model.dart';


///Types Return on HomeRepository
typedef ResultInsertSchedule = Either<Failure, bool>;
typedef ResultGetServices = Either<Failure, List<ServicesModel>>;
typedef ResultGetTimeFreeOnDaySelected
= Either<Failure, List<TimesModel>>;
typedef ResultGetSchedulesByDate = Either<Failure, List<SchedulesModel>>;
typedef ResultConfigurationDayScheduler
= Either<Failure, List<DateWithConfigModel>>;

///Types Return on AdminRepository
typedef ResultInsertNewTimes = Either<Failure, bool>;
typedef ResultDeleteTimes = Either<Failure, bool>;
typedef ResultAddNewVacancy = Either<Failure, bool>;
typedef ResultDatesWithConfig = Either<Failure, List<DateWithConfigModel>>;
typedef ResultDeleteConfig = Either<Failure, bool>;
typedef ResultInsertNewServices = Either<Failure, bool>;
typedef ResultAllSchedules = Either<Failure, Snapshot>;
typedef ResultDeleteSchedule = Either<Failure, bool>;