// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:llr/features/auth/data/api.dart';
import 'package:llr/features/auth/model/login_response_model.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../constants/app_constants.dart';
import '../../../../../../helpers/di.dart';
import '../../../../../../networks/rx_base.dart';

final class LoginRX extends RxResponseInt<LoginResponseModel> {
  String? errorMessage;
  final api = LoginApi.instance;

  LoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> login({required String email, required String password}) async {
    try {
      final data = await api.login(email: email, password: password);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(LoginResponseModel data) {
    appData.write(kKeyAccessToken, data.token);
    appData.write(kKeyIsLoggedIn, true);

    String token = appData.read(kKeyAccessToken);
    appData.write(KkuserId, data.userId);
    DioSingleton.instance.update(token);

    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        errorMessage = error.response!.data['message'];
      } else if (error.response!.data['code'] == 403) {
        errorMessage = error.response!.data['message'];
      } else if (error.response!.statusCode == 404) {
        ToastUtil.showSuccessMessage(error.response!.data!['message']);
      } else {
        errorMessage = error.response!.data['message'];
      }
    }
    // log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
