import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class FriendBlockApi {
  static final FriendBlockApi _singleton = FriendBlockApi._internal();
  FriendBlockApi._internal();

  static FriendBlockApi get instance => _singleton;

  Future<Map> block({required int userId}) async {
    try {
      FormData data = FormData.fromMap({"user_id": userId});

      Response response = await postHttp(EndPoints.friendBlock(), data);

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
