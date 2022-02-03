import '../repository/login_repository.dart';

abstract class LoginService {
  Future<ResultLogin> login({required String email, required String password});
  Future<ResultLogoof> deleteAccount();

}
