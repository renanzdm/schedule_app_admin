import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';

typedef ResultLogin = Either<Failure, UserModel>;

abstract class LoginRepository {
  Future<ResultLogin> login({required String email, required String password});
}
