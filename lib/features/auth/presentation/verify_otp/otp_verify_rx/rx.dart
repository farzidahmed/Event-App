import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/auth/presentation/verify_otp/model/otp_verify_model.dart';
import 'package:llr/features/auth/presentation/verify_otp/otp_verify_rx/api.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class VerifyOtpRx extends RxResponseInt<VerfiyOtpModel> {
  final api = VerifyOtpApi.instance;

  ValueStream get sendOtpStream => dataFetcher.stream; // fixed typo

  VerifyOtpRx({required super.empty, required super.dataFetcher});

  Future<VerfiyOtpModel> sendOtp({
    required String email,
    required String otp,
  }) async {
    try {
      VerfiyOtpModel data = await api.verfiy(email: email, otp: otp);
      await handleSuccessWithReturn(data);
      log("Data ====> $data");
      return data;
    } catch (e) {
      return handleErrorWithReturn(e);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(VerfiyOtpModel data) async {
    log('Success handling OTP verification');

    if (data.token!.isNotEmpty) {
      await appData.write(kKeyAccessToken, data.token);
      await appData.write(kKeyIsLoggedIn, true);

      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);

      log('Token saved and Dio updated');
      return true;
    } else {
      log('Token not found in response');
      return false;
    }
  }

  @override
  VerfiyOtpModel handleErrorWithReturn(error) {
    VerfiyOtpModel errorResponse = VerfiyOtpModel();

    if (error is DioException && error.response != null) {
      final statusCode = error.response!.statusCode;
      final errorData = error.response!.data;
      final errorMessage = errorData['message'] ?? "An unknown error occurred";

      ToastUtil.showErrorMessage(errorMessage);
      log("Error $statusCode: $errorMessage");
    } else {
      log("Unexpected error ===> $error");
      ToastUtil.showErrorMessage("An unexpected error occurred");
    }

    dataFetcher.sink.addError(error);
    return errorResponse;
  }
}
