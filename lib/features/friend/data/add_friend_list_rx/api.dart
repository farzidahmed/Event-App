import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/friend/model/add_friend_list_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class AddFriendApi {
  static final AddFriendApi _singleton = AddFriendApi._internal();
  AddFriendApi._internal();

  static AddFriendApi get instance => _singleton;

  Future<AddFriendListModel> addFriend() async {
    try {
      Response response = await getHttp(EndPoints.addFriend());
      if (response.statusCode == 200) {
        final data = AddFriendListModel.fromRawJson(json.encode(response.data));
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
