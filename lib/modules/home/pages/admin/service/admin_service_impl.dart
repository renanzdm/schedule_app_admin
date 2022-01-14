import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository_impl.dart';

import 'admin_service.dart';

class AdminServiceImpl implements AdminService {
  final AdminRepositoryImpl _adminRepositoryImpl;

  AdminServiceImpl({required AdminRepositoryImpl adminRepositoryImpl})
      : _adminRepositoryImpl = adminRepositoryImpl;

  @override
  Future<ResultInsertNewTimes> insertNewTimes({required String time}) async =>
      await _adminRepositoryImpl.insertNewTimes(time: time);

  @override
  Future<ResultDeleteTimes> deleteTime({required int id}) async =>
      await _adminRepositoryImpl.deleteTime(id: id);
}
