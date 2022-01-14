import 'package:get/get.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/modules/login/repository/login_repository_impl.dart';
import 'package:schedule_app_admin/modules/login/service/login_service_impl.dart';


import 'login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        LoginRepositoryImpl(clientHttp:Get.find<ClientHttp>()));
    Get.lazyPut(() =>
        LoginServiceImpl(loginRepository: Get.find<LoginRepositoryImpl>()));
    Get.lazyPut(() => LoginController(
        loginService: Get.find<LoginServiceImpl>(),sharedPreferencesService: Get.find<SharedPreferencesService>()
        ));
  }
}
