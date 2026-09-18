import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/festival_details/model/fseive_all_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class AllFestiveApi {
  static final AllFestiveApi _singleton = AllFestiveApi._internal();
  AllFestiveApi._internal();

  static AllFestiveApi get instance => _singleton;

  Future<AllFestiveModel> all() async {
    try {
      Response response = await getHttp(EndPoints.festive());
      if (response.statusCode == 200) {
        final data = AllFestiveModel.fromRawJson(json.encode(response.data));
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
