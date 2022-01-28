import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/modules/register/ui/register_module.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'app/app_binding/app_bindings.dart';
import 'app/ui/theme_default/manager_ui_theme.dart';
import 'modules/home/ui/home_module.dart';
import 'modules/login/ui/login_module.dart';
import 'modules/splash/splash_module.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://7f145e28a3cb4f9fa44ff279a0c22cb3@o1128671.ingest.sentry.io/6171617';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
}



class MyApp extends StatelessWidget {
  
  ///maind
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
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
      ],
      navigatorObservers: [
        SentryNavigatorObserver(),
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
