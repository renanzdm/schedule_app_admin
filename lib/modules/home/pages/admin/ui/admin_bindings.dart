import 'package:get/get.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository_impl.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/service/admin_service_impl.dart';
import 'package:schedule_app_admin/modules/home/services/home_service_impl.dart';

import 'admin_controller.dart';

class AdminBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AdminRepositoryImpl(clientHttp: Get.find<ClientHttp>()));
    Get.lazyPut(() => AdminServiceImpl(adminRepositoryImpl: Get.find<AdminRepositoryImpl>()));
    Get.lazyPut(
            () => AdminController(homeService: Get.find<HomeServiceImpl>(), adminService: Get.find<AdminServiceImpl>()));
  }

}