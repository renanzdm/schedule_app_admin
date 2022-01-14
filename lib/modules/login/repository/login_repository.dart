import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/modules/login/errors/login_errors.dart';

typedef ResultLogin = Either<LoginErrors, UserModel>;

abstract class LoginRepository {
  Future<ResultLogin> login({required String email, required String password});

}

