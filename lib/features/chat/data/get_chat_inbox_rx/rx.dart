// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/chat/data/get_chat_inbox_rx/api.dart';
import 'package:llr/features/chat/model/chat_inbox_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../../../networks/rx_base.dart';

final class GetChatDataRx extends RxResponseInt<ChatInboxModel> {
  GetChatDataRx({required super.empty, required super.dataFetcher});

  /// Stream getter for listening to updates
  ValueStream<ChatInboxModel> get getShowProvider => dataFetcher.stream;

  final api = GetChatDataApi.instance;

  /// Fetch chat data for a given userId
  Future<ChatInboxModel?> chatData(int userId) async {
    try {
      final data = await api.chatData(userId);
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  /// Handle API error and return a safe fallback
  @override
  ChatInboxModel? handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final response = error.response;

      if (response?.statusCode == 401) {
        /// Token expired or unauthorized — reset app state
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        final message = response?.data?["message"] ?? "Something went wrong";
        ToastUtil.showErrorMessage(message);
      }
    } else {
      /// Handle non-Dio errors
      ToastUtil.showErrorMessage("Unexpected error occurred");
    }

    log("ChatData Error: $error");
    dataFetcher.sink.addError(error);

    /// Return null or empty model to avoid crash
    return null;
  }
}
