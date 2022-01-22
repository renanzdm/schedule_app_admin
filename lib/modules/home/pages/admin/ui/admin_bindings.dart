import 'package:get/get.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/custom_hasura/custom_hasura.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository_impl.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/service/admin_service_impl.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';

import 'admin_controller.dart';

class AdminBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AdminRepositoryImpl(hasuraConnect: Get.find<CustomHasuraConnect>()));
    Get.lazyPut(() => AdminServiceImpl(adminRepositoryImpl: Get.find<AdminRepositoryImpl>()));
    Get.lazyPut(
            () => AdminController(homeController: Get.find<HomeController>(), adminService: Get.find<AdminServiceImpl>()));
  }

}