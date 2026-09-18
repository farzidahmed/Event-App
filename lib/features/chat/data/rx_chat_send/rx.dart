import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/chat/data/rx_chat_send/api.dart';
import 'package:llr/features/chat/model/send_model.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class SendMessageRx extends RxResponseInt<SendChatModel> {
  final api = SendMessageApi.instance;
  ValueStream get sendOtpSrteam => dataFetcher.stream;

  SendMessageRx({required super.empty, required super.dataFetcher});

  Future<SendChatModel> send({
   required int id,
    required String message,  
    String? filePath,
  }) async {
    try {
      SendChatModel data = await api.sendMessage(id: id, message: message, filePath: filePath);
      handleSuccessWithReturn(data);
      log("Data ====> $data");
      return data;
    } catch (e) {
      return handleErrorWithReturn(e);
    }
  }

  @override
  handleSuccessWithReturn(SendChatModel data) {
    
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    if (error is DioException) {
      if (error.response!.statusCode == 401) {
        ToastUtil.showErrorMessage("Invalid credentials");
      } else if (error.response!.data['code'] == 403) {
        ToastUtil.showErrorMessage("Invalid credentials");
      } else {
        // errorMessage = error.response!.data['message'];
      }
    }
    // log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
