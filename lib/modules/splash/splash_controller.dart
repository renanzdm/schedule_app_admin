import 'package:get/get.dart';
import 'package:schedule_app_admin/app/models/token_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';

enum UserState { logged, disconnected }

class SplashController extends GetxController {
  SplashController({required SharedPreferencesService sharedPreferencesService})
      : _sharedPreferencesService = sharedPreferencesService;
  final SharedPreferencesService _sharedPreferencesService;

  Future<UserState> getDataUserLogged() async {
  TokenModel? tokenModel =  await _sharedPreferencesService.getToken();
    if (tokenModel?.accessToken.isNotEmpty??false) {
      return UserState.logged;
    } else {
      return UserState.disconnected;
    }
  }
}
