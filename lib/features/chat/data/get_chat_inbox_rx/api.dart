import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/chat/model/chat_inbox_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class GetChatDataApi {
  static final GetChatDataApi _singleton = GetChatDataApi._internal();
  GetChatDataApi._internal();

  static GetChatDataApi get instance => _singleton;

  Future<ChatInboxModel> chatData(int userId) async {
    try {
      Response response = await getHttp(EndPoints.singleChat(userId));
      if (response.statusCode == 200) {
        final data = ChatInboxModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        log('Error: ${response.statusCode}');
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
