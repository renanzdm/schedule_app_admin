
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/models/token_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/login/service/login_service.dart';

class LoginController extends GetxController with LoaderMixin, MessageMixin {
  LoginController(
      {required LoginService loginService,
      required SharedPreferencesService sharedPreferencesService})
      : _loginService = loginService,
        _sharedPreferencesService = sharedPreferencesService;
  final LoginService _loginService;
  final SharedPreferencesService _sharedPreferencesService;
  final loading = Rx<bool>(false);
  final messages = Rxn<MessageModel>();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(messages);
  }

  Future<TokenModel?> loginEmailAndPassword(
      {required String email, required String password}) async {
    TokenModel? tokenModel;
    loading(true);
    var response = await _loginService.login(email: email, password: password);
    loading(false);
    response.fold(
      (err) {
        messages(MessageModel.error(
            title: 'Erro ao realizar login', message: err.error));
      },
      (token) {
        tokenModel = token;
      },
    );
    await _sharedPreferencesService.clearPreferences();
    await _sharedPreferencesService.setToken(
        token: tokenModel!.accessToken);
    return tokenModel;
  }
}
