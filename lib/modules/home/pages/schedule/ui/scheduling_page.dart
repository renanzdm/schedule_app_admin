import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/calendar_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/list_services_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/list_times_widget.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../app/ui/widgets/app_bar_custom_widget.dart';

class SchedulingPage extends StatefulWidget {
  const SchedulingPage({required Key key}) : super(key: key);
 

  @override
  State<SchedulingPage> createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  final _scrollController = ScrollController();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const AppBarCustomWidget(title: 'Agendamento',),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: PaddingDefault.screenPaddingHorizontal,
          child: Obx(
            () {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Faça seu Agendamento',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CalendarWidget(
                      dateSelected: _homeController.dateSelectedSchedule,
                      onTap: (CalendarTapDetails details) async {
                         _homeController.setDateSchedule(
                            date: details.date ?? DateTime.now());
                        await _homeController.onTapDateWidget();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (_homeController.listOfServices.isNotEmpty)
                      const Text(
                        'Escolha o Servico que deseja',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ListServicesWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_homeController.listOfTimes.isNotEmpty)
                      const Text(
                        'Escolha um horario',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTimesWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    _homeController.serviceIdSelected.value != -1 &&
                            _homeController.idHour.value != -1
                        ? _saveButton()
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _saveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: context.themeRed,
        fixedSize: Size(MediaQuery.of(context).size.width, 40.0),
      ),
      onPressed: () async {
        await _homeController.insertSchedule();
        _homeController.clearValuesForNewDate();
      },
      child: const Text(
        'Salvar',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
