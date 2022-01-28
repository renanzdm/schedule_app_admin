import 'package:hasura_connect/hasura_connect.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';

class HasuraTokenInterceptor extends InterceptorBase {
  final SharedPreferencesService _sharedPreferences =
      SharedPreferencesService();
  @override
  Future onError(HasuraError? error, HasuraConnect connect) async {
    return error;
  }

  @override
  Future onRequest(Request? request, HasuraConnect connect) async {
    UserModel? tokenModel = await _sharedPreferences.getUserModel();
    if (tokenModel != null) {
      request?.headers["Authorization"] = 'Bearer ${tokenModel.accessToken}';
      return request;
    }
  }
}
