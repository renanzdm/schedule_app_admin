import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/dialog_content_default.dart';
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

  List<PopupMenuEntry<ButtonPopUpMenuValue>> listButtons = [
    const PopupMenuItem(
      value: ButtonPopUpMenuValue.orderGrowing,
      child: Text(
        'Ordem Crescente',
        style: TextStyle(color: Colors.black),
      ),
    ),
    const PopupMenuItem(
      value: ButtonPopUpMenuValue.orderDescending,
      child: Text(
        'Ordem Decrescente',
        style: TextStyle(color: Colors.black),
      ),
    ),
     const PopupMenuItem(
      value: ButtonPopUpMenuValue.notFinisheds,
      child: Text(
        'Nao finalizadas',
        style: TextStyle(color: Colors.black),
      ),
    ),
     const PopupMenuItem(
      value: ButtonPopUpMenuValue.finisheds,
      child: Text(
        'Finalizadas',
        style: TextStyle(color: Colors.black),
      ),
    ),
    const PopupMenuItem(
      value: ButtonPopUpMenuValue.all,
      child: Text(
        'Todos os agendamentos',
        style: TextStyle(color: Colors.black),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        actions: [
          PopupMenuButton<ButtonPopUpMenuValue>(
            onSelected: (ButtonPopUpMenuValue value) {
                  _adminController.setValuePopButton(value);
            },
            icon: const Icon(Icons.filter_alt_outlined),
            itemBuilder: (context) {
              return listButtons;
            },
          )
        ],
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
                  physics: const BouncingScrollPhysics(),
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
            await showDialog(
                context: context,
                builder: (context) => DialogSimpleContentDefault(
                    title: 'Deseja apagar Agendamento?',
                    onConfirmFunction: () async {
                      await _adminController.deleteSchedule(item.id);
                      Navigator.pop(context);
                    },
                    onCancelFunction: () {
                      Navigator.pop(context);
                    },
                    cancelTextButton: 'Cancelar',
                    confirmTextButton: 'Apagar'));
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
