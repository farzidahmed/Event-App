import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/friend/model/request_accept.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class RequestAcceptApi {
  static final RequestAcceptApi _singleton = RequestAcceptApi._internal();
  RequestAcceptApi._internal();
  static RequestAcceptApi get instance => _singleton;

  Future<AcceptModel> accept({required String senderId}) async {
    try {
      Map data = {"sender_id": senderId};

      Response response = await postHttp(EndPoints.acceptRequest(), data);

      if (response.statusCode == 200) {
        final data = AcceptModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
