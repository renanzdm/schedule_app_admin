import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';
import 'package:schedule_app_admin/modules/home/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/services/home_service.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin {
  final HomeService _homeService;
  final SharedPreferencesService _sharedPreferencesService;

  HomeController(
      {required HomeService homeService,
      required SharedPreferencesService sharedPreferencesService})
      : _homeService = homeService,
        _sharedPreferencesService = sharedPreferencesService;
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
  RxList<DateWithConfigModel> listOfConfigurationByDay =
      RxList<DateWithConfigModel>();
  DateTime dateSelectedSchedule = DateTime.now();
  RxInt serviceIdSelected = RxInt(-1);
  RxInt idHour = RxInt(-1);

  @override
  Future<void> onReady() async {
    _loading(true);
    await getServices(showLoading: false);
    await getTimes(showLoading: false);
    await getScheduleByDate(showLoading: false);
    await getConfigurationDayScheduler(showLoading: false);
    configureListOfTimesCurrent();
    configuresTimesForConfig();
    setTheHoursIsBusy();
    _loading(false);
    super.onReady();
  }

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

  Future<void> setDateSchedule({required DateTime date}) async {
    dateSelectedSchedule = DateTime(date.year, date.month, date.day);
  }

  void setIdServiceSelected({required int id}) => serviceIdSelected.value = id;

  void setIdHour({required int id}) => idHour.value = id;

  Future<void> insertSchedule() async {
    UserModel? user = await _sharedPreferencesService.getUserModel();
    if(user!=null){
      _loading(true);
      var res = await _homeService.createSchedule(
          nameClient: user.name,
          dateSchedule: '${dateSelectedSchedule.year}-${dateSelectedSchedule.month}-${dateSelectedSchedule.day}',
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

  Future<void> getServices({bool showLoading =true}) async {
   if(showLoading)_loading(true);
    listOfServices.clear();
    var res = await _homeService.getServices();
    res.fold((l) {
      errorGetServices.value = l.error;
    }, (res) {
      listOfServices.addAll(res);
    });
   if(showLoading)_loading(false);
  }

  Future<void> getTimes({bool showLoading =true}) async {
   if(showLoading)_loading(true);
    listOfTimesDefault.clear();
    var res = await _homeService.getTimes();
    res.fold((l) {
      errorGetTimes.value = l.error;
    }, (res) {
      listOfTimesDefault.addAll(res);
    });
    if(showLoading)_loading(false);
  }

  Future<void> getScheduleByDate({bool showLoading =true}) async {
   if(showLoading)_loading(true);
    listOfSchedules.clear();
    var res = await _homeService.getScheduleByDate(
        date:
            '${dateSelectedSchedule.year}-${dateSelectedSchedule.month}-${dateSelectedSchedule.day}');
    res.fold((l) {
      errorGetSchedules.value = l.error;
    }, (res) {
      listOfSchedules.addAll(res);
    });
  if(showLoading)_loading(false);
  }

  Future<void> onTapDateWidget()async{
    _loading(true);
    await getServices(showLoading: false);
    await getTimes(showLoading: false);
    await getConfigurationDayScheduler(showLoading: false);
    await getScheduleByDate(showLoading: false);
    _loading(false);
    configureListOfTimesCurrent();
    configuresTimesForConfig();
    setTheHoursIsBusy();
  }




  Future<void> getConfigurationDayScheduler({bool showLoading =true}) async {
  if(showLoading)_loading(true);
    listOfConfigurationByDay.clear();
    var res = await _homeService.getConfigurationDaySelected(
        date:
            '${dateSelectedSchedule.year}-${dateSelectedSchedule.month}-${dateSelectedSchedule.day}');
    res.fold(
      (l) {},
      (res) {
        listOfConfigurationByDay.addAll(res);
      },
    );
  if(showLoading)_loading(false);
  }

  void configureListOfTimesCurrent() async {
    listOfTimes.clear();
    for (var element in listOfTimesDefault) {
      listOfTimes.add(TimesModel(
          id: element.id,
          qtdSchedulerPerHour: element.qtdSchedulerPerHour,
          time: element.time));
    }
  }

  void configuresTimesForConfig() async {
    for (var config in listOfConfigurationByDay) {
      for (var time in listOfTimes) {
        if (time.id == config.idHour) {
          time.qtdSchedulerPerHour = config.qtdOfVacancy;
        }
      }
    }
  }

  void setTheHoursIsBusy() async {
    for (var schedule in listOfSchedules) {
      for (var time in listOfTimes) {
        if (time.id == schedule.idHour) {
          time.qtdSchedulerPerHour--;
        }
      }
    }
  }

  clearListOfTimesCurrent() {
    listOfTimes.clear();
  }

  void clearValuesForNewDate() {
    listOfSchedules.clear();
    listOfTimes.clear();
    listOfConfigurationByDay.clear();
    setDateSchedule(date: DateTime.now());
    setIdHour(id: -1);
    setIdServiceSelected(id: -1);
  }
}
