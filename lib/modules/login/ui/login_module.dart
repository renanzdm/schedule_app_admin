import 'package:get/get.dart';
import 'package:schedule_app_admin/app/module/module.dart';

import 'login_bindings.dart';
import 'login_page.dart';

class LoginModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(name: '/login', page: () => LoginPage(), binding: LoginBindings()),
  ];
}
