import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/auth/presentation/verify_otp/model/otp_verify_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class VerifyOtpApi {
  static final VerifyOtpApi _singleton = VerifyOtpApi._internal();
  VerifyOtpApi._internal();
  static VerifyOtpApi get instance => _singleton;

  Future<VerfiyOtpModel> verfiy({
    required String email,
    required String otp,
  }) async {
    try {
      Map data = {'email': email, 'otp': otp};
      Response response = await postHttp(EndPoints.verifyOtp(), data);
      if (response.statusCode == 200) {
        final data = VerfiyOtpModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
