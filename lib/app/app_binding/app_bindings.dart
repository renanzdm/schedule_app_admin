import 'package:get/get.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/custom_hasura/custom_hasura.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';


class AppBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ClientHttp(),fenix: true);
    Get.lazyPut(() => CustomHasuraConnect(),fenix: true);
    Get.lazyPut(() => SharedPreferencesService(),fenix: true);
  }
}
