import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/ui/widgets/error_loaded_widget.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';

class ListTimesWidget extends StatelessWidget {
  ListTimesWidget({Key? key}) : super(key: key);

  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return SizedBox(
      width: sizes.width,
      child: Obx(
        () {
          if (_homeController.listOfTimes.isNotEmpty) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: _homeController.listOfTimes
                  .map(
                    (element) => AnimatedContainer(
                      key: UniqueKey(),
                      width: _homeController.idHour.value == element.id
                          ? 55
                          : 50,
                      height: _homeController.idHour.value == element.id
                          ? 55
                          : 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: _homeController.idHour.value == element.id
                              ? Border.all(color: context.themeRed, width: 3)
                              : null,
                          boxShadow:
                              _homeController.idHour.value == element.id
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
                                  _homeController.setIdHour(id: element.id);
                                  _homeController.setHour(hour: element.time);
                                },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                element.time,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration:
                                        element.qtdSchedulerPerHour == 0
                                            ? TextDecoration.lineThrough
                                            : null,
                                    color: element.qtdSchedulerPerHour == 0
                                        ? Colors.grey.shade600
                                        : Colors.black),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Vagas: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      decoration:
                                      element.qtdSchedulerPerHour == 0
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: element.qtdSchedulerPerHour == 0
                                          ? Colors.grey.shade600
                                          : Colors.black),
                                  children: [
                                    TextSpan(
                                        text: element.qtdSchedulerPerHour
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                element.qtdSchedulerPerHour ==
                                                        0
                                                    ? TextDecoration
                                                        .lineThrough
                                                    : null,
                                            color:
                                                element.qtdSchedulerPerHour ==
                                                        0
                                                    ? Colors.grey.shade600
                                                    : Colors.black))
                                  ],

                                ),
                              ),
                            ],
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
          } else if (_homeController.errorGetTimes.isNotEmpty) {
            return ErrorLoadedWidget(
              error: _homeController.errorGetTimes.value,
              reloadFunction: _homeController.getTimes,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
