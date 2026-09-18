import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/help_and_support/data/rx_get_help/api.dart';
import 'package:llr/features/help_and_support/model/faq_response.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../../../networks/rx_base.dart';

final class FaqRx extends RxResponseInt<FaqResponse> {
  FaqRx({required super.empty, required super.dataFetcher});

  ValueStream<FaqResponse> get faqList => dataFetcher.stream;
  final api = FaqApi.instance;

  Future<FaqResponse> getFaq() async {
    try {
      final data = await api.getFaq();
      handleSuccessWithReturn(data);

      return data;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        ToastUtil.showErrorMessage(
          error.response?.data["message"] ?? "Something went wrong",
        );
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
