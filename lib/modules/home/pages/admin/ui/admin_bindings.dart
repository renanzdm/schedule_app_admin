import 'package:get/get.dart';
import 'package:schedule_app_admin/modules/home/services/home_service_impl.dart';

import 'admin_controller.dart';

class AdminBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(
            () => AdminController(homeService: Get.find<HomeServiceImpl>()));
  }

}