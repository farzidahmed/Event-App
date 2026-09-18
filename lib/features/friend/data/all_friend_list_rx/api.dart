import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/friend/model/friend_request_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class FriendRequestApi {
  static final FriendRequestApi _singleton = FriendRequestApi._internal();
  FriendRequestApi._internal();

  static FriendRequestApi get instance => _singleton;

  Future<FriendRequestModel> request() async {
    try {
      Response response = await getHttp(EndPoints.requestList());
      if (response.statusCode == 200) {
        final data = FriendRequestModel.fromRawJson(json.encode(response.data));
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
