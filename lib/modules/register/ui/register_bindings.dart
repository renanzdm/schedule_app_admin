import 'package:get/get.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/modules/register/repository/register_repository_impl.dart';
import 'package:schedule_app_admin/modules/register/service/register_service_impl.dart';

import './register_controller.dart';

class RegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterServiceImpl(
        registerRepositoryImpl: Get.find<RegisterRepositoryImpl>()));
    Get.lazyPut(
        () => RegisterRepositoryImpl(clientHttp: Get.find<ClientHttp>()));
    Get.lazyPut(
        () => RegisterController(service: Get.find<RegisterServiceImpl>()));
  }
}
