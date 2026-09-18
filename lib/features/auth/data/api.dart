import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/auth/model/login_response_model.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class LoginApi {
  static final LoginApi _singleton = LoginApi._internal();
  LoginApi._internal();
  static LoginApi get instance => _singleton;

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      Map data = {"email": email, "password": password};

      Response response = await postHttp(EndPoints.login(), data);

      if (response.statusCode == 200) {
        final data = LoginResponseModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
