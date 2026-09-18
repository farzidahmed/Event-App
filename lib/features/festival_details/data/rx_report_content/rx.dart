import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/festival_details/data/rx_report_content/api.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class ReportContentRx extends RxResponseInt<Map> {
  ReportContentRx({required super.empty, required super.dataFetcher});

  ValueStream get getCartStream => dataFetcher.stream;
  final api = ReportContentApi.instance;

  Future<bool> reportUser(int? id, String description) async {
    try {
      final data = await api.report(userId: id!, description: description);
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
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        ToastUtil.showLongToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
