import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  final Function(CalendarTapDetails) onTap;
  final DateTime dateSelected;

  CalendarWidget(
      {Key? key,
      required this.onTap,
      required this.dateSelected,
     })
      : super(key: key);

  final DateTime _minDate =
          DateTime.now().subtract(const Duration(days: 365 ~/ 2)),
      _maxDate = DateTime.now().add(const Duration(days: 365 ~/ 2));

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

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      todayHighlightColor: context.themeRedAccent,
      minDate: _minDate,
      maxDate: _maxDate,
      showNavigationArrow: true,
      view: CalendarView.month,
      initialSelectedDate: dateSelected,
      backgroundColor: Colors.white,
      selectionDecoration: BoxDecoration(border: Border.all(color: Colors.red)),
      blackoutDates: getBlackoutDates(_minDate, _maxDate),
      blackoutDatesTextStyle: const TextStyle(
          color: Colors.black, decoration: TextDecoration.lineThrough),
      onTap: onTap,
      headerStyle: CalendarHeaderStyle(
        backgroundColor: context.themeRed,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
