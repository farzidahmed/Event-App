import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/helpers/toast.dart';

import '/networks/endpoints.dart';
import '../../../../../networks/dio/dio.dart';

final class SignupApi {
  static final SignupApi _singleton = SignupApi._internal();
  SignupApi._internal();
  static SignupApi get instance => _singleton;

  Future<Map> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPass,
  }) async {
    try {
      Map data = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPass,
        "agree": "true",
      };
      Response response = await postHttp(EndPoints.signup(), data);
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else if (response.statusCode == 400) {
        ToastUtil.showErrorMessage("user with this email already");
      } else {
        Map data = json.decode(json.encode(response.data));

        return data;
        // throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // SignUpResponse _signUpRes = SignUpResponse.fromJson(error);
      rethrow;
    }
    throw Exception('Signup failed with unknown error.');
  }
}
