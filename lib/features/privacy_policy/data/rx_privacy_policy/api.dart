import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/privacy_policy/model/privacy_policy_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class PrivacyPolicyApi {
  static final PrivacyPolicyApi _singleton = PrivacyPolicyApi._internal();
  PrivacyPolicyApi._internal();

  static PrivacyPolicyApi get instance => _singleton;

  Future<PrivacyPolicyResponse> privacyPolicy() async {
    try {
      Response response = await getHttp(EndPoints.privacyPolicy());
      if (response.statusCode == 200) {
        final data = PrivacyPolicyResponse.fromRawJson(
          json.encode(response.data),
        );
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
