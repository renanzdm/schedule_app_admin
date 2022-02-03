import 'package:get/get.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
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

  Future<UserModel> loginEmailAndPassword(
      {required String email, required String password}) async {
    UserModel userModel =
        const UserModel(name: '', phone: '', id: -1, accessToken: '');
    loading(true);
    var response = await _loginService.login(email: email, password: password);
    loading(false);
    response.fold(
      (err) {
        messages(MessageModel.error(
            title: err.error.toString(), message: err.message ?? ''));
      },
      (user) {
        userModel = user;
      },
    );
    await _sharedPreferencesService.setUserModel(user: userModel);
    return userModel;
  }

  Future<bool> deleteAccount() async {
    loading(true);
    var response = await _loginService.deleteAccount();
    loading(false);
    bool resultRequest = false;
    response.fold(
      (err) async {
        await _sharedPreferencesService.clearPreferences();
        messages(MessageModel.error(
            title: err.error.toString(), message: err.message ?? ''));
      },
      (success) {
        resultRequest = success;
      },
    );
    return resultRequest;
  }
}
