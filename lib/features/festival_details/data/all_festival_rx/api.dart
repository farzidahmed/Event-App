import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/festival_details/model/allalums_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class AllAlumsApi {
  static final AllAlumsApi _singleton = AllAlumsApi._internal();
  AllAlumsApi._internal();

  static AllAlumsApi get instance => _singleton;

  Future<AllAlumsModel> all() async {
    try {
      Response response = await getHttp(EndPoints.allAlbums());
      if (response.statusCode == 200) {
        final data = AllAlumsModel.fromRawJson(json.encode(response.data));
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
