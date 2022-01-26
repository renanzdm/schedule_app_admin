import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

import '../admin_controller.dart';

class FieldVacancy extends StatelessWidget {
   FieldVacancy({Key? key}) : super(key: key);
  final _adminController = Get.find<AdminController>();


  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          alignment: Alignment.center,
          child: Text(
            _adminController.vacancyValue.value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: context.themeRed,
            ),
          ),
          height: 60,
          width: MediaQuery.of(context).size.width * .3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 2, color: context.themeRed),
          ),
        );
      }
    );
  }
}
