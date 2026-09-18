import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/search/model/search_festival_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class FestivalSearchApi {
  static final FestivalSearchApi _singleton = FestivalSearchApi._internal();
  FestivalSearchApi._internal();

  static FestivalSearchApi get instance => _singleton;

  Future<SearchFestivalResponse> searchFestival({
    required String search,
  }) async {
    try {
      Response response = await getHttp(EndPoints.searchFestival(search));
      if (response.statusCode == 200) {
        final data = SearchFestivalResponse.fromRawJson(
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
