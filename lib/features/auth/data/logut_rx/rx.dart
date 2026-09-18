import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/auth/data/logut_rx/api.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/networks/rx_base.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/rxdart.dart';

final class LogoutRx extends RxResponseInt<Map> {
  final api = LogoutApi.instance;
  ValueStream get getLoginSrteam => dataFetcher.stream;

  LogoutRx({required super.empty, required super.dataFetcher});

  Future<bool> logout() async {
    try {
      final data = await api.logout();
      handleSuccessWithReturn(data);
      log("Data ====> $data");
      return true;
    } catch (e) {
      return handleErrorWithReturn(e);
    }
  }

  @override
  void handleSuccessWithReturn(data) {
    appData.write(kKeyIsLoggedIn, false);
    totalDataClean();
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      if (error.response != null && error.response!.statusCode == 422) {
      } else if (error.response!.statusCode == 404) {
      } else if (error.response!.statusCode == 401) {
        await appData.write(kKeyIsLoggedIn, false);
        totalDataClean();
        NavigationService.popAndReplace(Routes.loginScreen);
      } else {}
    } else {
      log("Error ====> $error");
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    throw error;
  }
}
