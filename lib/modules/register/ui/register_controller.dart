import 'package:get/get.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/register/service/register_service.dart';

class RegisterController extends GetxController with LoaderMixin, MessageMixin {
  final RegisterService _registerService;

  RegisterController({
    required RegisterService service,
  }) : _registerService = service;

  final loading = Rx<bool>(false);
  final messages = Rxn<MessageModel>();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(messages);
  }

  Future<UserModel?> registerFirebase(
      {required String email,
      required String password,
      required String name,
      String? defaultRole,
      required String phone}) async {
    UserModel? userModel;
    loading(true);
    var response = await _registerService.registerUser(
        email: email,
        password: password,
        name: name,
        phone: phone);

    loading(false);
    response.fold(
      (err) {
        messages(MessageModel.error(
            title: 'Erro ao realizar seu cadastro', message: err.error ?? ''));
      },
      (user) async {
        userModel = user;
        messages(MessageModel.info(
            title: 'Successo', message: 'Cadastrado com sucesso'));
      },
    );
    return userModel;
  }
}
