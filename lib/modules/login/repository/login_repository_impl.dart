
import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/client_http/client_http.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/modules/login/errors/login_errors.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ClientHttp _clientHttp;

  LoginRepositoryImpl({required ClientHttp clientHttp})
      : _clientHttp = clientHttp;

  @override
  Future<ResultLogin> login(
      {required String email, required String password}) async {
    try {
      var response = await _clientHttp
          .post('/auth/login', data: {'email': email, 'password': password});
      int? statusCode = response.data['code'];
      switch (statusCode) {
        case 200:
          return right(UserModel.fromMap(response.data['data']));
        case 403:
          return left(EmailOrPasswordIncorrect(error: response.data['data']));
        case 401:
          return left(EmailOrPasswordIncorrect(error: response.data['data']));
        default:
          return left(EmailOrPasswordIncorrect(error: 'Erro desconhecido'));
      }
    } catch (e, s) {
      return left(UnknownError(error: e,stackTrace: s));
    }
  }
}
