import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/error/failure.dart';
import 'package:schedule_app_admin/modules/register/errors/register_errors.dart';

typedef RegisterResultResponse = Either<Failure, bool>;

abstract class RegisterRepository {
  Future<RegisterResultResponse> registerUser({
    required String email,
    required String password,
    String? rule,
    required String name,
    required String phone,
  });
}
