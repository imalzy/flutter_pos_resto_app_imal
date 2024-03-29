import 'package:dartz/dartz.dart';
import 'package:flutter_posresto_app/core/constants/variables.dart';
import 'package:flutter_posresto_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_posresto_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/login');
    final body = {'email': email, 'password': password};
    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(AuthResponseModel.fromJson(response.body).message ?? '');
    }
  }

  Future<Either<String, bool>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/logout');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData.accessToken}',
    });
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left(AuthResponseModel.fromJson(response.body).message ?? '');
    }
  }
}
