import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class ReportContentApi {
  static final ReportContentApi _singleton = ReportContentApi._internal();
  ReportContentApi._internal();

  static ReportContentApi get instance => _singleton;

  Future<Map> report({required int userId, required String description}) async {
    try {
      FormData data = FormData.fromMap({"description": description});

      Response response = await postHttp(
        EndPoints.reportFestival(userId),
        data,
      );

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
