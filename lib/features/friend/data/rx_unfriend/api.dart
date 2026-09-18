import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class UnFriendApi {
  static final UnFriendApi _singleton = UnFriendApi._internal();
  UnFriendApi._internal();

  static UnFriendApi get instance => _singleton;

  Future<Map> unFriend({required int friendId}) async {
    try {
      FormData data = FormData.fromMap({});

      Response response = await postHttp(EndPoints.unFriend(friendId), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
