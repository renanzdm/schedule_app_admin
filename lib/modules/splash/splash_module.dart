import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:schedule_app_admin/app/module/module.dart';
import 'package:schedule_app_admin/modules/splash/splash_bindings.dart';
import 'package:schedule_app_admin/modules/splash/splash_page.dart';

class SplashModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/',
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
  ];
}
