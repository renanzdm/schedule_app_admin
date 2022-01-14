import 'package:get/get.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/admin_controller.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/repositories/schedule_repository_impl.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/services/schedule_service_impl.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/ui/schedule_controller.dart';
import 'package:schedule_app_admin/modules/home/repositories/home_repository_impl.dart';
import 'package:schedule_app_admin/modules/home/services/home_service_impl.dart';
import 'package:schedule_app_admin/modules/home/widgets/bottom_navigation_bar/bottom_navigation_bar_controller.dart';

import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeRepositoryImpl(clientHttp: Get.find<ClientHttp>()));
    Get.lazyPut(() =>
        HomeServiceImpl(homeRepositoryImpl: Get.find<HomeRepositoryImpl>()));
    Get.lazyPut(() => HomeController(homeService: Get.find<HomeServiceImpl>()));
    Get.lazyPut(() => BottomNavigationBarController());



    ///Dependecies of schedule module
    Get.lazyPut(
        () => ScheduleRepositoryImpl(clientHttp: Get.find<ClientHttp>()));
    Get.lazyPut(() => ScheduleServiceImpl(
        scheduleRepository: Get.find<ScheduleRepositoryImpl>()));
    Get.lazyPut(() => ScheduleController(
        scheduleService: Get.find<ScheduleServiceImpl>(),
        homeService: Get.find<HomeServiceImpl>(),sharedPreferencesService: Get.find<SharedPreferencesService>()));
  }
}
