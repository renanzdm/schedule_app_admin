import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/dialog_message.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/error_loaded_widget.dart';
import 'package:schedule_app_admin/modules/home/models/schedules_model.dart';
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
    _adminController.getAllSchedulesSubscription();
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
          child: Obx(
            () {
              return Visibility(
                visible: _adminController.listOfSchedule.isNotEmpty,
                replacement: const Center(
                  child: ErrorLoadedWidget(
                    error: 'Ainda não há agendamentos',
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: _adminController.listOfSchedule.length,
                  itemBuilder: (context, index) {
                    var item = _adminController.listOfSchedule[index];
                    return ScheduleWidget(item: item);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  ScheduleWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SchedulesModel item;
  final _adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      width: MediaQuery.of(context).size.width,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            offset: Offset(4.0, 6.0),
            blurRadius: 2,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onLongPress: () async {
            await DialogAlertAction.showDialogWidget(
                context: context,
                titleDialog: 'Deseja apagar Agendamento?',
                confirmFunction: () async {
                  await _adminController.deleteSchedule(item.id);
                  Navigator.pop(context);
                });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.nameClient,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Data: ',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: item.dateSchedule,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'Serviço: ',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: item.nameService,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300))
                            ]),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Hora: ',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: item.hour,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
