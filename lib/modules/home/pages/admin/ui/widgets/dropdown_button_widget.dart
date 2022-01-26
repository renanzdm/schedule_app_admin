import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/modules/home/models/times_model.dart';

import '../admin_controller.dart';

class DropDownButtonWidget extends StatelessWidget {
  final _adminController = Get.find<AdminController>();

  DropDownButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton(
        elevation: 10,
        value: _adminController.selectedItemDropDownButton.value,
        iconEnabledColor: context.themeRed,
        iconSize: 30,
        hint: const Text(
          'Selecione um horário',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        dropdownColor: context.themeRed,
        items: _adminController.listOfTimesDefault
            .map<DropdownMenuItem<TimesModel>>(
              (TimesModel element) => DropdownMenuItem(
            child: Row(
              children: [
                Text(
                  element.time,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
            value: element,
          ),
        )
            .toList(),
        isExpanded: true,
        onChanged: (TimesModel? v) {
          _adminController.selectedItemDropDownButton.value = v!;
        },
      );
    });
  }
}
