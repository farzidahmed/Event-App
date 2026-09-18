import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/festival_details/data/review_like_rx/api.dart';
import 'package:llr/features/festival_details/model/review_like_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/rx_base.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/rxdart.dart';

final class ReviewLikeRx extends RxResponseInt<ReviewModelLike> {
  ReviewLikeRx({required super.empty, required super.dataFetcher});

  ValueStream get allAlumbs => dataFetcher.stream;
  final api = ReviewLikeApi.instance;

  Future<ReviewModelLike> reviewLike(int id) async {
    try {
      final data = await api.reviewLike(id);
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  ReviewModelLike handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        ToastUtil.showErrorMessage(error.response?.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return ReviewModelLike();
  }
}
