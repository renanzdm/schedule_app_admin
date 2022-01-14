
import 'package:schedule_app_admin/modules/register/repository/register_repository.dart';

abstract class RegisterService {
  Future<RegisterResultResponse> registerUser({
    required String email,
    required String password,
    String? rule,
    required String name,
    required String phone,
  });
}
