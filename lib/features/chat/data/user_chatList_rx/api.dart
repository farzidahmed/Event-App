import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/chat/model/user_list_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class UserChatListApi {
  static final UserChatListApi _singleton = UserChatListApi._internal();
  UserChatListApi._internal();

  static UserChatListApi get instance => _singleton;

  Future<UserListModel> userList() async {
    try {
      Response response = await getHttp(EndPoints.userChatList());
      if (response.statusCode == 200) {
        final data = UserListModel.fromRawJson(json.encode(response.data));
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
