import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/festival_details/model/review_model.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class ReviewApi {
  static final ReviewApi _singleton = ReviewApi._internal();
  ReviewApi._internal();
  static ReviewApi get instance => _singleton;

  Future<ReviewModel> review({
    required String id,
    required int rating,
    required String review,
  }) async {
    try {
      Map data = {"artist_id": id, "rating": rating, "comment": review};

      Response response = await postHttp(EndPoints.review(), data);

      if (response.statusCode == 200) {
        final data = ReviewModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
