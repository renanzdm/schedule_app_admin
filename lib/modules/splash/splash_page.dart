import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/modules/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = Get.find<SplashController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
        var userState = await _splashController.getDataUserLogged();
        switch (userState) {
          case UserState.logged:
            await 1.delay();
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case UserState.disconnected:
            await 1.delay();
            Navigator.of(context).pushReplacementNamed('/login');
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
