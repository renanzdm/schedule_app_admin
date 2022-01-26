import 'package:fpdart/fpdart.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/modules/register/errors/register_errors.dart';

typedef RegisterResultResponse = Either<RegisterErrors, bool>;

abstract class RegisterRepository {
  Future<RegisterResultResponse> registerFirebase({
    required String email,
    required String password,
    String? rule,
    required String name,
    required String phone,
  });
}
