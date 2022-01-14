import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/widgets/error_loaded_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/schedule_controller.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/service_item_widget.dart';


class ListServicesWidget extends StatelessWidget {
  ListServicesWidget({Key? key}) : super(key: key);
  final _scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_scheduleController.listOfServices.isNotEmpty) {
          return Column(
            children: _scheduleController.listOfServices
                .map<Widget>((service) => ServiceItemWidget(
                      name: service.name,
                      price: service.price,
                      description: service.description,
                      id: service.id,
                    ))
                .toList(),
          );
        } else if (_scheduleController.errorGetServices.isNotEmpty) {
          return ErrorLoadedWidget(
            error: _scheduleController.errorGetServices.value,
            reloadFunction: _scheduleController.getServices,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
