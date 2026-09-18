import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/friend/model/my_all_friend_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class MyAllFriendApi {
  static final MyAllFriendApi _singleton = MyAllFriendApi._internal();
  MyAllFriendApi._internal();

  static MyAllFriendApi get instance => _singleton;

  Future<MyAllFriendModel> allFriend() async {
    try {
      Response response = await getHttp(EndPoints.myAllFriend());
      if (response.statusCode == 200) {
        final data = MyAllFriendModel.fromRawJson(json.encode(response.data));
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
