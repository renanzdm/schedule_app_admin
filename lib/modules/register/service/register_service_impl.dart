



import 'package:schedule_app_admin/modules/register/repository/register_repository.dart';
import 'package:schedule_app_admin/modules/register/service/register_service.dart';

class RegisterServiceImpl implements RegisterService {
  final RegisterRepository _registerRepositoryImpl;

  RegisterServiceImpl({required RegisterRepository registerRepositoryImpl})
      : _registerRepositoryImpl = registerRepositoryImpl;

  @override
  Future<RegisterResultResponse> registerUser({
    required String email,
    required String password,
     String? rule,
    required String name,
    required String phone,
  }) async =>
      await _registerRepositoryImpl.registerUser(
          email: email, password: password,name: name,phone: phone);


}
