import 'package:flutter_posresto_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  final prefsKey = 'auth_data';
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefsKey, authResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefsKey);
  }

  Future<AuthResponseModel> getAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final authData = prefs.getString(prefsKey);
    return AuthResponseModel.fromJson(authData!);
  }

  Future<bool> isAuthDataExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(prefsKey);
  }
}
