import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/calendar_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/widgets/add_new_vacancy_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/widgets/dropdown_button_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/widgets/list_date_with_config_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../admin_controller.dart';

class AddNewVacancy extends StatefulWidget {
  const AddNewVacancy({Key? key}) : super(key: key);

  @override
  State<AddNewVacancy> createState() => _AddNewVacancyState();
}

class _AddNewVacancyState extends State<AddNewVacancy> {
  final _adminController = Get.find<AdminController>();


  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novas Vagas'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: PaddingDefault.screenPaddingHorizontal,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                CalendarWidget(
                  dateSelected: _adminController.dateSelectedSchedule,
                  onTap: (CalendarTapDetails details) async {
                    _adminController.setDateSchedule(
                        date: details.date ?? DateTime.now());
                    await _adminController.getConfigs();
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                 const Text(
                  'Configurações neste dia',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                 const SizedBox(
                  height: 20,
                ),
                ListDateWithConfigWidget(),
                DropDownButtonWidget(),
                AddNewVacancyWidget(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: context.themeRed,
                    fixedSize: Size(sizes.width, 40.0),
                  ),
                  onPressed: () async {
                    await _adminController.addNewVacancy();
                  },
                  child: const Text(
                    'Adicionar Novas Vagas',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
