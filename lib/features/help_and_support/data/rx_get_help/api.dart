import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/help_and_support/model/faq_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class FaqApi {
  static final FaqApi _singleton = FaqApi._internal();
  FaqApi._internal();

  static FaqApi get instance => _singleton;

  Future<FaqResponse> getFaq() async {
    try {
      Response response = await getHttp(EndPoints.faq());
      if (response.statusCode == 200) {
        final data = FaqResponse.fromRawJson(json.encode(response.data));
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
