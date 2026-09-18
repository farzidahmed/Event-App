import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class UnBlockApi {
  static final UnBlockApi _singleton = UnBlockApi._internal();
  UnBlockApi._internal();

  static UnBlockApi get instance => _singleton;

  Future<Map> unBlock({required int userId}) async {
    try {
      FormData data = FormData.fromMap({"user_id": userId});

      Response response = await postHttp(EndPoints.unBlockUser(), data);

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
