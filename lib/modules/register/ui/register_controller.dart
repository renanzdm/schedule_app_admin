import 'package:get/get.dart';
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

  Future<bool> registerUser(
      {required String email,
        required String password,
        required String name,
        required String phone}) async {
    bool result =false;
    loading(true);
    var response = await _registerService.registerUser(
        email: email, password: password, name: name,phone: phone);

    loading(false);
    response.fold(
          (err) {
        result =false;
        messages(MessageModel.error(
            title: 'Erro ao realizar seu cadastro', message: err.error.toString()));
      },
          (user) async {
        result =true;
        messages(MessageModel.info(
            title: 'Successo', message: 'Cadastrado com sucesso'));
      },
    );
    return result;
  }
}
