import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/profile/model/my_alumbs_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class MyAlumbsApi {
  static final MyAlumbsApi _singleton = MyAlumbsApi._internal();
  MyAlumbsApi._internal();

  static MyAlumbsApi get instance => _singleton;

  Future<MyAlumbsModel> myAlumbs(int type) async {
    try {
      Response response = await getHttp(EndPoints.myAlumbs(type));
      if (response.statusCode == 200) {
        final data = MyAlumbsModel.fromRawJson(json.encode(response.data));
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
