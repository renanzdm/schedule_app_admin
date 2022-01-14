import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/admin_controller.dart';

class AddNewHours extends StatefulWidget {
  const AddNewHours({Key? key}) : super(key: key);

  @override
  State<AddNewHours> createState() => _AddNewHoursState();
}

class _AddNewHoursState extends State<AddNewHours> {
  final _adminController = Get.find<AdminController>();

  Widget _showTimePicker(Size sizes) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: context.themeRed,
        fixedSize: Size(sizes.width, 40.0),
      ),
      onPressed: () async {
        showTimePicker(
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
      },
      child: const Text(
        'Adicionar Novo Horário',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Horário'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: PaddingDefault.screenPaddingHorizontal,
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: [
                  ..._adminController.listOfTimesDefault
                      .map((e) => Container(
                    margin: const EdgeInsets.only(top: 4,bottom: 4),
                    height: 60,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow:const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(2,4),
                        blurRadius: 4

                      )
                    ],
                    color: Colors.white,
                    ),
                    width: sizes.width,
                    child: Text(e.time),
                  ))
                      .toList(),
                  _showTimePicker(sizes),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
