import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/service/admin_service.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/services/home_service.dart';

class AdminController extends GetxController with LoaderMixin, MessageMixin {
  final HomeService _homeService;
  final AdminService _adminService;

  AdminController(
      {required HomeService homeService, required AdminService adminService})
      : _homeService = homeService,
        _adminService = adminService;

  final _loading = Rx<bool>(false);
  final _messages = Rxn<MessageModel>();
  RxList<TimesModel> listOfTimesDefault = RxList<TimesModel>([]);
  RxString errorGetTimes = RxString('');
  DateTime dateSelectedSchedule = DateTime.now();


  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_messages);
  }

  @override
  void onReady() async {
    await getTimes();
  }


  Future<void> queueFunctionCallInsertNewHours({required TimeOfDay time}) async {
    _loading(true);
    var insertTimes = await insertNewHours(time: time);
    if(insertTimes){
      await getTimes(showLoading: false);
    }
    _loading(false);
  }

  Future<void> queueFunctionCallDeleteHours({required int id}) async {
    _loading(true);
    var insertTimes = await deleteTime(id: id);
    if(insertTimes){
      await getTimes(showLoading: false);
    }
    _loading(false);
  }

  void setDateSchedule({required DateTime date}) =>
      dateSelectedSchedule = DateTime(date.year, date.month, date.day);


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

  Future<void> getTimes({bool showLoading=true}) async {
    if(showLoading) _loading(true);
    var res = await _homeService.getTimes();
    if(showLoading) _loading(false);
    res.fold((l) {
      errorGetTimes.value = l.error;
    }, (r) {
      listOfTimesDefault.clear();
      errorGetTimes.value = '';
      listOfTimesDefault.addAll(r);
    });
  }

  Future<bool> insertNewHours({required TimeOfDay time}) async {
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    bool result =false;
    var res = await _adminService.insertNewTimes(time: hour+':'+minute);
    res.fold((l) {result =false;}, (r) {result =true;});
   return result;

  }

  Future<bool> deleteTime({required int id}) async {
    bool result =false;
    var res = await _adminService.deleteTime(id: id);
    res.fold((l) {result =false;}, (r) {result =true;});
    return result;

  }



}
