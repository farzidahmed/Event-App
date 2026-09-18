import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/friend/model/request_accept.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class RequestSenderApi {
  static final RequestSenderApi _singleton = RequestSenderApi._internal();
  RequestSenderApi._internal();
  static RequestSenderApi get instance => _singleton;

  Future<AcceptModel> sender({required String reciverId}) async {
    try {
      Map data = {"receiver_id": reciverId};

      Response response = await postHttp(EndPoints.sendRequest(), data);

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
