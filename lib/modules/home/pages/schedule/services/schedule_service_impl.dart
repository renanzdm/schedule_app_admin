import 'package:schedule_app_admin/modules/home/pages/schedule/repositories/schedule_repository.dart';

import './schedule_service.dart';

class ScheduleServiceImpl implements ScheduleService {
  final ScheduleRepository _scheduleRepository;

  ScheduleServiceImpl({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository;

  @override
  Future<ResultInsertSchedule> createSchedule(
          {required String nameClient,
          required DateTime dateSchedule,
          required int serviceId,
          required int idHour,
          required int idUser}) async =>
      _scheduleRepository.createSchedule(
          nameClient: nameClient,
          dateSchedule: dateSchedule,
          serviceId: serviceId,
          idHour: idHour,
          idUser: idUser);

  @override
  Future<ResultGetServices> getServices() async =>
      _scheduleRepository.getServices();

  @override
  Future<ResultGetSchedulesByDate> getScheduleByDate(
          {required DateTime date}) async =>
      _scheduleRepository.getScheduleByDate(date: date);

  @override
  Future<ResultConfigurationDayScheduler> getConfigurationDayScheduler(
          {required DateTime date}) =>
      _scheduleRepository.getConfigurationDayScheduler(date: date);
}
