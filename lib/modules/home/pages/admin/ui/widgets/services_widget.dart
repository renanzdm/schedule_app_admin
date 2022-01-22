import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/utils/utils.dart';

import 'package:schedule_app_admin/modules/home/pages/admin/ui/admin_controller.dart';

class ServicesWidget extends StatelessWidget {
  ServicesWidget({Key? key}) : super(key: key);
  final _adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_adminController.listOfServices.isNotEmpty) {
          return Column(
            children: _adminController.listOfServices
                .map<Widget>((service) => Container(
                      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        onLongPress: () async {
                          await _adminController.deleteService(id: service.id);
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                Utils.formatForMoney(price: service.price),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(service.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(service.description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
