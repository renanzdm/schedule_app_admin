import 'package:get/get.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/modules/splash/splash_controller.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(
        sharedPreferencesService: Get.find<SharedPreferencesService>()));
  }
}
