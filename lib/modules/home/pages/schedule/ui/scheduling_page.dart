import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/schedule_controller.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/calendar_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/list_services_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/list_times_widget.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';



class SchedulingPage extends StatefulWidget {
  const SchedulingPage({Key? key}) : super(key: key);

  @override
  State<SchedulingPage> createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  final _scrollController = ScrollController();
  final _scheduleController = Get.find<ScheduleController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    CalendarWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    if (_scheduleController.listOfServices.isNotEmpty)
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
                    if (_scheduleController.listOfTimes.isNotEmpty)
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
                    _scheduleController.serviceIdSelected.value != -1 &&
                            _scheduleController.idHour.value != -1
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

        await _scheduleController.insertSchedule();

        _scheduleController.clearValuesForNewDate();
      },
      child: const Text(
        'Salvar',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
