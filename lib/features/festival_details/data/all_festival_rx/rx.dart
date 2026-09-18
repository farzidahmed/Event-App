import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/festival_details/data/all_festival_rx/api.dart';
import 'package:llr/features/festival_details/model/allalums_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class AllAlumsRx extends RxResponseInt<AllAlumsModel> {
  AllAlumsRx({required super.empty, required super.dataFetcher});

  ValueStream get allAlumbs => dataFetcher.stream;
  final api = AllAlumsApi.instance;

  Future<AllAlumsModel> all() async {
    try {
      final data = await api.all();
      handleSuccessWithReturn(data);

      return data;
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
        ToastUtil.showErrorMessage(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
