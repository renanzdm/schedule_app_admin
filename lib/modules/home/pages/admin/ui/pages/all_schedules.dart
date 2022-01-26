import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/admin_controller.dart';

class AllSchedules extends StatefulWidget {
  const AllSchedules({Key? key}) : super(key: key);

  @override
  State<AllSchedules> createState() => _AllSchedulesState();
}

class _AllSchedulesState extends State<AllSchedules> {
  final _adminController = Get.find<AdminController>();
  @override
  void initState() {
    _adminController.getAllSchedulesSibscription();
    super.initState();
  }

  @override
  void dispose() {
    _adminController.disposer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
      ),
      body: SizedBox(
        child: Padding(
            padding: PaddingDefault.screenPaddingHorizontal,
            child: Obx(() {
              return ListView.builder(
                itemCount: _adminController.listOfSchedule.length,
                itemBuilder: (context, index) {
                  var item = _adminController.listOfSchedule[index];
                  return ListTile(
                    title: Text(
                      item.nameClient,
                      style: const TextStyle(
                        color: Colors.white,fontSize: 20
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(item.dateSchedule,style: const TextStyle(
                        color: Colors.white,fontSize: 12
                      ),),
                      ],
                    ),
                  );
                },
              );
            })),
      ),
    );
  }
}
