import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:schedule_app_admin/app/module/module.dart';
import 'package:schedule_app_admin/modules/register/ui/register_bindings.dart';


import 'register_page.dart';

class RegisterModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
        name: '/register',
        page: () => RegisterPage(),
        binding: RegisterBindings())
  ];
}
