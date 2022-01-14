
import 'package:schedule_app_admin/modules/home/pages/admin/repository/admin_repository.dart';

abstract class AdminService{
  Future<ResultInsertNewTimes> insertNewTimes({required String time});
  Future<ResultDeleteTimes> deleteTime({required int id });


}