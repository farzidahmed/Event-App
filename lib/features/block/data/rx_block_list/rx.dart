import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/block/data/rx_block_list/api.dart';
import 'package:llr/features/block/model/block_user_response.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../../networks/rx_base.dart';

final class BlockUserListRx extends RxResponseInt<BlockUserModelResponse> {
  BlockUserListRx({required super.empty, required super.dataFetcher});

  ValueStream<BlockUserModelResponse> get blockUserList => dataFetcher.stream;
  final api = BlockUserApi.instance;

  Future<BlockUserModelResponse> blockUser() async {
    try {
      final data = await api.blockUser();
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
