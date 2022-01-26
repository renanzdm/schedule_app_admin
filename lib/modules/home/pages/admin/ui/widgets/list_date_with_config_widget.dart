
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin_controller.dart';

class ListDateWithConfigWidget extends StatelessWidget {
  final _adminController = Get.find<AdminController>();

  ListDateWithConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: _adminController.listDatesOfConfig
              .map(
                (element) => Container(
                  margin: const EdgeInsets.only(top: 6.0,bottom: 6.0),
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
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onLongPress: () async {
                        await _adminController.deleteConfig(id: element.idConfig);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Data Configurada: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700),
                                children: [
                                  TextSpan(
                                    text: element.date,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 8.0,),
                              RichText(
                                text: TextSpan(
                                  text: 'Horário: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade700),
                                  children: [
                                    TextSpan(
                                      text: element.time,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Vagas: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade700),
                                  children: [
                                    TextSpan(
                                      text: element.qtdOfVacancy.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
