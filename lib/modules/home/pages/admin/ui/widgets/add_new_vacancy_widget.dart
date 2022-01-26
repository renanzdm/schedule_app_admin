import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/widgets/field_vacancy.dart';

import '../admin_controller.dart';
import 'button_add_or_remove_vacancy.dart';

class AddNewVacancyWidget extends StatelessWidget {
  AddNewVacancyWidget({Key? key}) : super(key: key);
  final _adminController = Get.find<AdminController>();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          FieldVacancy(),
          const SizedBox(
            width: 50,
          ),
          ButtonAddOrRemoveVacancy(icon: Icons.add,onTap: (){_adminController.addVacancy();},),
          const SizedBox(
            width: 30,
          ),
          ButtonAddOrRemoveVacancy(icon: Icons.remove,onTap: (){_adminController.removeVacancy();},)
        ],
      ),
    );
  }
}