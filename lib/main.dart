import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/modules/register/ui/register_module.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'app/app_binding/app_bindings.dart';
import 'app/ui/theme_default/manager_ui_theme.dart';
import 'modules/home/ui/home_module.dart';
import 'modules/login/ui/login_module.dart';
import 'modules/splash/splash_module.dart';


main(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales:const [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
      ],
      locale: const Locale('pt'),
      theme: ManagerUiTheme.theme(context),
      title: 'Agendamento',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      getPages: [
        ...SplashModule().routers,
        ...LoginModule().routers,
        ...HomeModule().routers,
        ...RegisterModule().routers
      ],
    );
  }
}
