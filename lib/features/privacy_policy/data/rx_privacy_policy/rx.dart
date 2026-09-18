import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/privacy_policy/data/rx_privacy_policy/api.dart';
import 'package:llr/features/privacy_policy/model/privacy_policy_response.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class PrivacyPolicyRx extends RxResponseInt<PrivacyPolicyResponse> {
  PrivacyPolicyRx({required super.empty, required super.dataFetcher});

  ValueStream get getTermsStream => dataFetcher.stream;
  final api = PrivacyPolicyApi.instance;
  Future<bool> privacyPolicy() async {
    try {
      final data = await api.privacyPolicy();
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 401) {
        totalDataClean();
        //appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        ToastUtil.showErrorMessage(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
