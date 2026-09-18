import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/festival_details/data/festival_details_rx/model/alumbs_details_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class AllAlumsDetailsApi {
  static final AllAlumsDetailsApi _singleton = AllAlumsDetailsApi._internal();
  AllAlumsDetailsApi._internal();

  static AllAlumsDetailsApi get instance => _singleton;

  Future<AllAlumbsDetailsModel> details(int id) async {
    try {
      Response response = await getHttp(EndPoints.allbumsDetails(id));
      if (response.statusCode == 200) {
        final data = AllAlumbsDetailsModel.fromRawJson(
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
