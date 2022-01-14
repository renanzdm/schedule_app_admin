
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../admin_controller.dart';

class AddNewVacancy extends StatefulWidget {
  const AddNewVacancy({Key? key}) : super(key: key);

  @override
  State<AddNewVacancy> createState() => _AddNewVacancyState();
}

class _AddNewVacancyState extends State<AddNewVacancy> {
  final _adminController = Get.find<AdminController>();

  Widget _showTimePicker(Size sizes) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: context.themeRed,
        fixedSize: Size(sizes.width, 40.0),
      ),
      onPressed: () async {
        TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 9, minute: 0),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
              MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if(time!=null) {
          await _adminController.queueFunctionCallInsertNewHours(time: time);
        }
      },
      child: const Text(
        'Adicionar Novo Horário',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novas Vagas'),
      ),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Padding(
          padding: PaddingDefault.screenPaddingHorizontal,
          child: SingleChildScrollView(
            child: Column(
              children:  [
                 const SizedBox(
                  height: 30,
                ),
                 const Text(
                  'Adicione novas vagas para horários e determinada data',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                CalendarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CalendarWidget extends StatelessWidget {
  CalendarWidget({Key? key}) : super(key: key);
  final _adminController = Get.find<AdminController>();

  final DateTime _minDate =
  DateTime.now().subtract(const Duration(days: 365 ~/ 2)),
      _maxDate = DateTime.now().add(const Duration(days: 365 ~/ 2));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingDefault.screenPaddingHorizontal,
      child: SfCalendar(
        todayHighlightColor: context.themeRedAccent,
        minDate: _minDate,
        maxDate: _maxDate,
        showNavigationArrow: true,
        view: CalendarView.month,
        initialSelectedDate:_adminController.dateSelectedSchedule,
        backgroundColor: Colors.white,
        selectionDecoration:
        BoxDecoration(border: Border.all(color: Colors.red)),
        blackoutDates: _adminController.getBlackoutDates(_minDate, _maxDate),
        blackoutDatesTextStyle: const TextStyle(
            color: Colors.black, decoration: TextDecoration.lineThrough),
        onTap: (CalendarTapDetails details) async {
          _adminController.setDateSchedule(date:details.date ?? DateTime.now());
        },
        headerStyle: CalendarHeaderStyle(
          backgroundColor: context.themeRed,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

