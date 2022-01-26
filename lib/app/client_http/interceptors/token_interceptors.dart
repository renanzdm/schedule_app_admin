import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      SharedPreferencesService();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    UserModel? tokenModel = await _sharedPreferences.getUserModel();
    options.headers.addAll({
      'Authorization': tokenModel != null && tokenModel.accessToken.isNotEmpty
          ? 'Bearer ${tokenModel.accessToken}'
          : ''
    });
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    int? errorCode = err.response?.statusCode;
    if (errorCode == 403) {
      await _sharedPreferences.clearPreferences();
     _alertError();
      await 3.delay();
      Get.offAllNamed('/login');
    } else {
      handler.next(err);
    }
  }


  _alertError()  {
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
                    children: const [
                      Icon(
                        Icons.error_outline_outlined,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text(
                        'Ops...',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Seu token expirou, por favor faça Login denovo',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        barrierDismissible: false);
  }


}
