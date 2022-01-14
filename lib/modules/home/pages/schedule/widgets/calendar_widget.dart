import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({Key? key}) : super(key: key);
  final _scheduleController = Get.find<ScheduleController>();

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
        initialSelectedDate:_scheduleController.dateSelectedSchedule,
        backgroundColor: Colors.white,
        selectionDecoration:
            BoxDecoration(border: Border.all(color: Colors.red)),
        blackoutDates: _scheduleController.getBlackoutDates(_minDate, _maxDate),
        blackoutDatesTextStyle: const TextStyle(
            color: Colors.black, decoration: TextDecoration.lineThrough),
        onTap: (CalendarTapDetails details) async {
          _scheduleController.setDateSchedule(
              date: details.date ?? DateTime.now());

          await _scheduleController.queueFunctionCallCalendarWidget();
        },
        headerStyle: CalendarHeaderStyle(
          backgroundColor: context.themeRed,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
