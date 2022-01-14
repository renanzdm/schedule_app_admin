import 'package:schedule_app_admin/app/models/token_model.dart';
import 'package:schedule_app_admin/app/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> setToken({required String token}) async {
    final _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setString('accessToken', token);
    } catch (e) {
      Exception('Error ao salvar token no shared preferences');
    }
  }

  Future<void> setUserModel({required UserModel user}) async {
    final _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setString('id', user.id.toString());
      _preferences.setString('name', user.name);
      _preferences.setString('phone', user.phone);
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
      return UserModel(
        id: int.tryParse(id??'')??-1,
        name: name ?? '',
        phone: phone ?? '',
      );
    } catch (e) {
      Exception('Error ao recuperar usuario no shared preferences');
    }
  }

  Future<TokenModel?> getToken() async {
    final _preferences = await SharedPreferences.getInstance();
    try {
      String? accessToken = _preferences.getString('accessToken');

      return TokenModel(
        accessToken: accessToken ?? '',
      );
    } catch (e) {
      Exception('Error ao pegar token no shared preferences');
    }
  }

  Future clearPreferences() async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }
}
