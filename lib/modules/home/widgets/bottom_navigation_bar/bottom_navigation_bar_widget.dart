import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

import 'bottom_navigation_bar_controller.dart';


class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({Key? key}) : super(key: key);

  final bottomNavigationController = Get.find<BottomNavigationBarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return BottomNavigationBar(
          onTap: (int index) => bottomNavigationController.changePage(index),
          backgroundColor: context.themeRed,
          currentIndex: bottomNavigationController.currentIndex.value,
          selectedIconTheme: const IconThemeData(color: Colors.white, size: 26),
          selectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
          unselectedIconTheme:
              const IconThemeData(color:Colors.white70,size:22),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Agendamento',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.shopping_bag_outlined),
            //   label: 'Produtos',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.video_collection_outlined),
            //   label: 'Nossos Serviços',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel_sharp),
              label: 'Administrador',
            ),
          ],
        );
      },
    );
  }
}
