import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/widgets/error_loaded_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/schedule_controller.dart';

import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class ListTimesWidget extends StatelessWidget {
  ListTimesWidget({Key? key}) : super(key: key);

  final _scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return SizedBox(
      width: sizes.width,
      child: Obx(
        () {
          if (_scheduleController.listOfTimes.isNotEmpty) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: _scheduleController.listOfTimes
                  .map(
                    (element) => AnimatedContainer(
                      key: UniqueKey(),
                      width: _scheduleController.idHour.value ==
                              element.id
                          ? 55
                          : 50,
                      height: _scheduleController.idHour.value ==
                              element.id
                          ? 55
                          : 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: _scheduleController.idHour.value ==
                                  element.id
                              ? Border.all(color: context.themeRed, width: 3)
                              : null,
                          boxShadow:
                              _scheduleController.idHour.value ==
                                      element.id
                                  ? <BoxShadow>[
                                      const BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(4.0, 6.0),
                                        blurRadius: 2,
                                      )
                                    ]
                                  : <BoxShadow>[]),
                      duration: const Duration(milliseconds: 1000),
                      child: Material(
                        color: element.qtdSchedulerPerHour == 0
                            ? Colors.grey.shade200
                            : null,
                        child: InkWell(
                          onTap: element.qtdSchedulerPerHour == 0
                              ? null
                              : () {
                                  _scheduleController.setIdHour(
                                      id: element.id);
                                },
                          child: Center(
                            child: Text(
                              element.time,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: element.qtdSchedulerPerHour == 0
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: element.qtdSchedulerPerHour == 0
                                      ? Colors.grey.shade600
                                      : Colors.black),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else if (_scheduleController.errorGetTimes.isNotEmpty) {
            return ErrorLoadedWidget(
              error: _scheduleController.errorGetTimes.value,
              reloadFunction: _scheduleController.getTimes,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
