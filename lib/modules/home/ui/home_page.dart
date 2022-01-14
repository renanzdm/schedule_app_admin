import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/admin_page.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/scheduling_page.dart';
import 'package:schedule_app_admin/modules/home/widgets/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:schedule_app_admin/modules/home/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _listPages = <Widget>[
    const SchedulingPage(),
   // const ProductsPage(),
   // const ServicesPage(),
    const AdminPage(),
  ];
  final bottomNavigationController = Get.find<BottomNavigationBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: SizedBox(
        child: Obx(() {
          return IndexedStack(
            index: bottomNavigationController.currentIndex.value,
            children: _listPages,
          );
        }),
      ),
    );
  }
}
