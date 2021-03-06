import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/home/models/dates_with_config_model.dart';
import 'package:schedule_app_admin/modules/home/models/schedules_model.dart';
import 'package:schedule_app_admin/modules/home/models/services_model.dart';
import 'package:schedule_app_admin/modules/home/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/service/admin_service.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';

enum ButtonPopUpMenuValue {
  orderGrowing,
  orderDescending,
  finisheds,
  notFinisheds,
  all
}

class AdminController extends GetxController with LoaderMixin, MessageMixin {
  final HomeController _homeController;
  final AdminService _adminService;

  AdminController(
      {required HomeController homeController,
      required AdminService adminService})
      : _homeController = homeController,
        _adminService = adminService;

  final _loading = Rx<bool>(false);
  final _messages = Rxn<MessageModel>();
  RxList<TimesModel> listOfTimesDefault = RxList<TimesModel>([]);
  RxList<ServicesModel> listOfServices = RxList<ServicesModel>([]);
  RxList<DateWithConfigModel> listDatesOfConfig =
      RxList<DateWithConfigModel>([]);
  RxString errorGetTimes = RxString('');
  RxString errorDeleteService = RxString('');
  DateTime dateSelectedSchedule = DateTime.now();
  Rxn<TimesModel> selectedItemDropDownButton = Rxn(null);
  Rx<int> vacancyValue = Rx<int>(0);
  RxList<SchedulesModel> listOfSchedule = RxList<SchedulesModel>([]);
  RxList<SchedulesModel> listOfScheduleBackup = RxList<SchedulesModel>([]);

  StreamSubscription? allSchedulesSubscription;
  Snapshot? allSchedulesSnapshot;
  Rx<ButtonPopUpMenuValue> valuePopButton =
      Rx<ButtonPopUpMenuValue>(ButtonPopUpMenuValue.orderDescending);

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_messages);
  }

  void addVacancy() => vacancyValue.value++;
  void removeVacancy() {
    if (vacancyValue.value > 0) vacancyValue.value--;
  }

  @override
  void onReady() async {
    await getConfigs();
    listOfTimesDefault.assignAll(_homeController.listOfTimesDefault);
    listOfServices.assignAll(_homeController.listOfServices);
    selectedItemDropDownButton.value = listOfTimesDefault.first;
  }

  void setValuePopButton(ButtonPopUpMenuValue value) {
    valuePopButton.value = value;
    listSchedulesFiltered();
  }

  void listSchedulesFiltered() {
    if (valuePopButton.value == ButtonPopUpMenuValue.orderGrowing) {
      reverseOrderListSchedule();
    } else if (valuePopButton.value == ButtonPopUpMenuValue.orderDescending) {
      reverseOrderListSchedule();
    } else if (valuePopButton.value == ButtonPopUpMenuValue.finisheds) {
      filterByFinished();
    } else if (valuePopButton.value == ButtonPopUpMenuValue.notFinisheds) {
      filterByNotFinished();
    } else {
      reasignListScheduleOfBackup();
    }
  }

  void reverseOrderListSchedule() {
    reasignListScheduleOfBackup();
    listOfScheduleBackup.value = listOfScheduleBackup.reversed.toList();
    listOfSchedule.value = listOfSchedule.reversed.toList();
  }

  void filterByFinished() {
    reasignListScheduleOfBackup();
    listOfSchedule.value =
        listOfSchedule.where((item) => item.finished == false).toList();
  }

  void filterByNotFinished() {
    reasignListScheduleOfBackup();
    listOfSchedule.value =
        listOfSchedule.where((item) => item.finished == true).toList();
  }

  void reasignListScheduleOfBackup() {
    listOfSchedule.clear();
    for (var element in listOfScheduleBackup) {
      listOfSchedule.add(SchedulesModel(
          dateSchedule: element.dateSchedule,
          finished: element.finished,
          hour: element.hour,
          id: element.id,
          idHour: element.idHour,
          nameClient: element.nameClient,
          nameService: element.nameService,
          serviceId: element.serviceId));
    }
  }

  void setDateSchedule({required DateTime date}) {
    dateSelectedSchedule = DateTime(date.year, date.month, date.day);
    _homeController.setDateSchedule(
        date: DateTime(date.year, date.month, date.day));
  }

  Future<void> getConfigs() async {
    await _homeController.getConfigurationDayScheduler(showLoading: true);
    listDatesOfConfig.assignAll(_homeController.listOfConfigurationByDay);
  }

  Future<void> insertNewHours({required TimeOfDay time}) async {
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    _loading(true);
    var res = await _adminService.insertNewTimes(time: hour + ':' + minute);
    _loading(false);
    res.fold((l) {
      _messages(MessageModel.error(
          title: 'Erro ao inserir um hor??rio', message: 'TODO'));
    }, (r) async {
      await _homeController.getTimes(showLoading: false);
      listOfTimesDefault.assignAll(_homeController.listOfTimesDefault);
    });
  }

  Future<void> deleteTime({required int id}) async {
    _loading(true);
    var res = await _adminService.deleteTime(id: id);
    _loading(false);
    res.fold((l) {
      _messages(MessageModel.error(
          title: 'Erro ao excluir um hor??rio', message: 'TODO'));
    }, (r) async {
      await _homeController.getTimes(showLoading: false);
      listOfTimesDefault.assignAll(_homeController.listOfTimesDefault);
    });
  }

  Future<void> addNewVacancy() async {
    _loading(true);

    var res = await _adminService.addNewVacancy(
        date:
            '${dateSelectedSchedule.year}-${dateSelectedSchedule.month}-${dateSelectedSchedule.day}',
        idHour: selectedItemDropDownButton.value!.id,
        qtdVacancy: vacancyValue.value);
    _loading(false);
    res.fold((l) {
      _messages(MessageModel.error(title: l.error.toString(), message: ''));
    }, (r) async {
      await _homeController.getConfigurationDayScheduler();
      listDatesOfConfig.assignAll(_homeController.listOfConfigurationByDay);
    });
  }

  Future<void> deleteConfig({required int id}) async {
    _loading(true);
    var res = await _adminService.deleteConfigById(id: id);
    _loading(false);
    res.fold((l) {}, (r) async {
      await _homeController.getConfigurationDayScheduler();
      listDatesOfConfig.assignAll(_homeController.listOfConfigurationByDay);
    });
  }

  Future<void> insertNewServices(
      {required String name,
      required String description,
      required String price}) async {
    _loading(true);
    var res = await _adminService.insertNewServices(
        name: name,
        description: description,
        price: int.parse(price.replaceAll(RegExp(r'\D'), '')));
    res.fold((l) {
      _messages(MessageModel.error(
          title: 'Erro ao criar novo servico', message: 'TODO'));
    }, (r) async {
      await _homeController.getServices();
      listOfServices.assignAll(_homeController.listOfServices);
    });
  }

  Future<void> deleteService({required int id}) async {
    _loading(true);
    var res = await _adminService.deleteServiceById(id: id);
    _loading(false);
    res.fold((l) {
      _messages(MessageModel.error(
          title: 'Error ao excluir Servico', message: 'Error'));
    }, (r) async {
      await _homeController.getServices();
      listOfServices.assignAll(_homeController.listOfServices);
    });
  }

  Future<void> getAllSchedulesSubscription() async {
    var res = await _adminService.getAllSchedules();
    res.fold((l) {
      _messages(MessageModel.error(
          title: 'Error ao excluir Servico', message: 'Error'));
    }, (r) {
      allSchedulesSnapshot = r;
      allSchedulesSubscription = r.listen((event) {
        listOfSchedule.clear();
        listOfScheduleBackup.clear();
        listOfScheduleBackup.addAll((event?['data']?['app_schedules'] ?? [])
            .map<SchedulesModel>((e) => SchedulesModel.fromMap(e))
            .toList());
        reasignListScheduleOfBackup();
      });
    });
  }

  Future<void> deleteSchedule(int id) async {
    _loading(true);
    var res = await _adminService.deleteSchedule(id: id);
    _loading(false);
    res.fold((l) => print(l), (r) {
      print(r);
    });
  }

  void disposer() {
    allSchedulesSnapshot?.close();
    allSchedulesSubscription?.cancel();
  }
}
