import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/profile/model/user_details_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class UserDetailsApi {
  static final UserDetailsApi _singleton = UserDetailsApi._internal();
  UserDetailsApi._internal();

  static UserDetailsApi get instance => _singleton;

  Future<UserDetailsModel> userDetails() async {
    try {
      Response response = await getHttp(EndPoints.userDetails());
      if (response.statusCode == 200) {
        final data = UserDetailsModel.fromRawJson(json.encode(response.data));
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
