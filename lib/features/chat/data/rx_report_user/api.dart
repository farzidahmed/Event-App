import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class ReportUserApi {
  static final ReportUserApi _singleton = ReportUserApi._internal();
  ReportUserApi._internal();

  static ReportUserApi get instance => _singleton;

  Future<Map> report({required String description, required int userId}) async {
    try {
      FormData data = FormData.fromMap({"description": description});

      Response response = await postHttp(EndPoints.reportUser(userId), data);

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
