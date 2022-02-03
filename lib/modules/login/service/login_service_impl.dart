

import 'package:schedule_app_admin/modules/login/repository/login_repository.dart';

import 'login_service.dart';

class LoginServiceImpl implements LoginService {
  final LoginRepository _loginRepository;

  LoginServiceImpl({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  @override
  Future<ResultLogin> login(
          {required String email, required String password}) async =>
      await _loginRepository.login(email: email, password: password);

  @override
  Future<ResultLogoof> deleteAccount() async=>await _loginRepository.deleteAccount();

}
