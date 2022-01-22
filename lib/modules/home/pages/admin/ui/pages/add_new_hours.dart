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
        await _adminController.insertNewHours(time: time);
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
            physics: const BouncingScrollPhysics(),
            child: Obx(() {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Estes são os horários que estão configurados',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      ..._adminController.listOfTimesDefault
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(top: 4, bottom: 4),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: context.themeRed, width: 1),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(4.0, 6.0),
                                    blurRadius: 2,
                                  )
                                ],
                                color: Colors.white,
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  onLongPress: () async {
                                    await _adminController.deleteTime(id: e.id);
                                  },
                                  child: Center(
                                    child: Text(
                                      e.time,
                                      style:const TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
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
