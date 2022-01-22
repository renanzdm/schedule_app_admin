import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/widgets/error_loaded_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/service_item_widget.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';


class ListServicesWidget extends StatelessWidget {
  ListServicesWidget({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_homeController.listOfServices.isNotEmpty) {
          return Column(
            children: _homeController.listOfServices
                .map<Widget>((service) => ServiceItemWidget(
                      name: service.name,
                      price: service.price,
                      description: service.description,
                      id: service.id,
                    ))
                .toList(),
          );
        } else if (_homeController.errorGetServices.isNotEmpty) {
          return ErrorLoadedWidget(
            error: _homeController.errorGetServices.value,
            reloadFunction: _homeController.getServices,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
