import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:schedule_app_admin/app/module/module.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/pages/add_new_hours.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/pages/add_new_services.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/pages/add_new_vacancy.dart';

import 'home_bindings.dart';
import 'home_page.dart';


class HomeModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/home',
      page: () =>  HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: '/add_hours',
      page: () => const AddNewHours(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: '/add_vacancy',
      page: () =>const  AddNewVacancy(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: '/add_services',
      page: () => const AddNewServices(),
      binding: HomeBindings(),
    ),
  ];
}
