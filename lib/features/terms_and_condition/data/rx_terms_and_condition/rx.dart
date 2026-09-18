import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/terms_and_condition/data/rx_terms_and_condition/api.dart';
import 'package:llr/features/terms_and_condition/model/term_and_conditon_response.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class TermsAndConditionRx extends RxResponseInt<TermsAndCodnition> {
  TermsAndConditionRx({required super.empty, required super.dataFetcher});

  ValueStream get getTermsStream => dataFetcher.stream;
  final api = TermsAndConditionApi.instance;
  Future<bool> termsAndCondition() async {
    try {
      final data = await api.termsAndCondition();
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
