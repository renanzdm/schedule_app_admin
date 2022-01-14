import 'package:get/get.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/configuration_day_scheduler.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/services/schedule_service.dart';
import 'package:schedule_app_admin/modules/home/services/home_service.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';

class ScheduleController extends GetxController with LoaderMixin, MessageMixin {
  final ScheduleService _scheduleService;
  final HomeService _homeService;
  final SharedPreferencesService _sharedPreferencesService;


  ScheduleController({required ScheduleService scheduleService,required HomeService homeService, required SharedPreferencesService sharedPreferencesService})
      : _scheduleService = scheduleService,_homeService=homeService,_sharedPreferencesService = sharedPreferencesService;

  final _loading = Rx<bool>(false);
  final _messages = Rxn<MessageModel>();
  RxList<ServicesModel> listOfServices = RxList<ServicesModel>([]);
  RxList<TimesModel> listOfTimesOnFreeByDay = RxList<TimesModel>([]);
  RxList<TimesModel> listOfTimesDefault = RxList<TimesModel>([]);
  RxList<TimesModel> listOfTimes = RxList<TimesModel>([]);
  RxString errorGetServices = RxString('');
  RxString errorGetTimes = RxString('');
  RxString errorGetSchedules = RxString('');
  RxList<SchedulesModel> listOfSchedules = RxList<SchedulesModel>();
  RxList<ConfigurationDayScheduler> listOfConfigurationByDay =
      RxList<ConfigurationDayScheduler>();
  DateTime dateSelectedSchedule = DateTime.now();
  RxInt serviceIdSelected = RxInt(-1);
  RxInt idHour = RxInt(-1);

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_messages);
  }




  List<DateTime> getBlackoutDates(DateTime minDate, DateTime maxDate) {
    final List<DateTime> dates = <DateTime>[];
    for (DateTime date = minDate;
        date.isBefore(maxDate);
        date = date.add(const Duration(days: 1))) {
      if (date.weekday == DateTime.sunday) {
        dates.add(date);
      }
    }
    return dates;
  }

  void setDateSchedule({required DateTime date}) =>
      dateSelectedSchedule = DateTime(date.year, date.month, date.day);

  void setIdServiceSelected({required int id}) => serviceIdSelected.value = id;

  void setIdHour({required int id}) => idHour.value = id;

  Future<void> queueFunctionCallCalendarWidget() async {
    _loading(true);
   var times= await  getTimes();
   if(times){
     var schedules = await getScheduleByDate();
     if (schedules) {
       var configDays = await getConfigurationDayScheduler();
       if (configDays) {
         var services = await getServices();
         if (services) {
           configuresAmountOfSchedulesPerDay();
           setTheHoursIsBusy();
         }
       }
     }
   }
   _loading(false);
  }

  Future<void> insertSchedule() async {
    UserModel? user = await _sharedPreferencesService.getUserModel();
    if(user!=null){
      _loading(true);
      var res = await _scheduleService.createSchedule(
          nameClient: user.name,
          dateSchedule: dateSelectedSchedule,
          serviceId: serviceIdSelected.value,
          idHour: idHour.value,
          idUser: user.id);
      _loading(false);
      res.fold(
            (l) =>
            _messages(MessageModel.error(title: 'Error', message: l.toString())),
            (r) => _messages(
          _messages(MessageModel.info(
              title: 'Sucesso', message: 'Sucesso ao registrar')),
        ),
      );
    }else{
      _messages(MessageModel.error(title: 'Error', message: 'Dados do usuário estão incorretos'));
    }

  }

  Future<bool> getServices() async {
    bool result = false;
    var res = await _scheduleService.getServices();
    res.fold((l) {
      errorGetServices.value = l.error;
      result = false;
    }, (r) {
      listOfServices.clear();
      errorGetServices.value = '';
      listOfServices.addAll(r);
      result = true;
    });
    return result;
  }

  Future<bool> getTimes() async {
    _loading(true);
    bool result = false;
    var res = await _homeService.getTimes();
    _loading(false);
    res.fold((l) {
      errorGetTimes.value = l.error;
      result = false;
    }, (r) {
      listOfTimesDefault.clear();
      errorGetTimes.value = '';
      listOfTimesDefault.addAll(r);
      result = true;
    });
    return result;
  }

  Future<bool> getScheduleByDate() async {
    var res =
        await _scheduleService.getScheduleByDate(date: dateSelectedSchedule);
    bool result = false;
    res.fold((l) {
      errorGetSchedules.value = l.error;
      result = false;
    }, (r) {
      result = true;
      listOfSchedules.clear();
      errorGetSchedules.value = '';
      listOfSchedules.addAll(r);
    });
    return result;
  }

  Future<bool> getConfigurationDayScheduler() async {
    bool result = false;
    var res = await _scheduleService.getConfigurationDayScheduler(
        date: dateSelectedSchedule);
    res.fold((l) => result = false, (r) {
      result = true;
      listOfConfigurationByDay.clear();
      listOfConfigurationByDay.addAll(r);
    });
    return result;
  }

  void configuresAmountOfSchedulesPerDay() {
    listOfTimes.clear();
    for (var element in listOfTimesDefault) {
      listOfTimes.add(TimesModel(
          id: element.id,
          qtdSchedulerPerHour: element.qtdSchedulerPerHour,
          time: element.time));
    }
    for (var config in listOfConfigurationByDay) {
      for (var time in listOfTimes) {
        if (time.id == config.idHour) {
          time.qtdSchedulerPerHour = config.qtdScheduleOnDay;
        }
      }
    }
  }

  void setTheHoursIsBusy() {
    for (var schedule in listOfSchedules) {
      for (var time in listOfTimes) {
        if (time.id == schedule.idHour) {
          time.qtdSchedulerPerHour--;
        }
      }
    }
  }

  void clearValuesForNewDate() {
    listOfSchedules.clear();
    listOfServices.clear();
    listOfTimes.clear();
    listOfConfigurationByDay.clear();
    setDateSchedule(date: DateTime.now());
    setIdHour(id: -1);
    setIdServiceSelected(id: -1);
  }
}
