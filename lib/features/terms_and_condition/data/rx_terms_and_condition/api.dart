import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/terms_and_condition/model/term_and_conditon_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class TermsAndConditionApi {
  static final TermsAndConditionApi _singleton =
      TermsAndConditionApi._internal();
  TermsAndConditionApi._internal();

  static TermsAndConditionApi get instance => _singleton;

  Future<TermsAndCodnition> termsAndCondition() async {
    try {
      Response response = await getHttp(EndPoints.termsAndCondition());
      if (response.statusCode == 200) {
        final data = TermsAndCodnition.fromRawJson(json.encode(response.data));
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
