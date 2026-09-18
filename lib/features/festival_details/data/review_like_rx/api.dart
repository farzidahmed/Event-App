import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/festival_details/model/review_like_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class ReviewLikeApi {
  static final ReviewLikeApi _singleton = ReviewLikeApi._internal();
  ReviewLikeApi._internal();

  static ReviewLikeApi get instance => _singleton;

  Future<ReviewModelLike> reviewLike(int id) async {
    try {
      Response response = await postHttp(EndPoints.reviewLike(id));
      if (response.statusCode == 200) {
        final data = ReviewModelLike.fromRawJson(json.encode(response.data));
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
