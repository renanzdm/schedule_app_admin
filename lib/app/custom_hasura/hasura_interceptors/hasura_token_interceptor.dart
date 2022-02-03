import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';

class HasuraTokenInterceptor extends InterceptorBase {
  final SharedPreferencesService _sharedPreferences =
      SharedPreferencesService();
  @override
  Future onError(HasuraError? error, HasuraConnect connect) async {
    String? errorCode = error?.message;
    if (errorCode == 'Could not verify JWT: JWTExpired') {
      await _sharedPreferences.clearPreferences();
      _alertError();
      await 100.delay();
      Get.offAllNamed('/login');
    }
    return error;
  }

  @override
  Future onRequest(Request? request, HasuraConnect connect) async {
    UserModel? tokenModel = await _sharedPreferences.getUserModel();
    if (tokenModel != null) {
      request?.headers["Authorization"] = 'Bearer ${tokenModel.accessToken}';
      return request;
    }
  }
}

_alertError() {
  Get.dialog(
      Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  )),
              width: 300,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline_outlined,
                      color: Colors.red,
                      size: 60,
                    ),
                    Text(
                      'Ops...',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Seu token expirou, por favor faça Login denovo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      barrierDismissible: false);
}
