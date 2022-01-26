import 'package:schedule_app_admin/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {


  Future<void> setUserModel({required UserModel user}) async {
    final _preferences = await SharedPreferences.getInstance();
    try {
      await _preferences.setString('id', user.id.toString());
      await _preferences.setString('name', user.name);
      await _preferences.setString('phone', user.phone);
      await  _preferences.setString('accessToken', user.accessToken);
    } catch (e) {
      Exception('Error ao salvar usuario no shared preferences');
    }
  }

  Future<UserModel?> getUserModel() async {
    final _preferences = await SharedPreferences.getInstance();
    try {
      String? id = _preferences.getString('id');
      String? name = _preferences.getString('name');
      String? phone = _preferences.getString('phone');
      String? accessToken = _preferences.getString('accessToken');
      return UserModel(
        id: int.tryParse(id??'')??-1,
        name: name ?? '',
        phone: phone ?? '', accessToken: accessToken??'',
      );
    } catch (e) {
      Exception('Error ao recuperar usuario no shared preferences');
    }
  }



  Future clearPreferences() async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }
}
