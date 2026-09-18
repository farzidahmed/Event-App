import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/festival_details/model/review_comment_model.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class ReviewCommentApi {
  static final ReviewCommentApi _singleton = ReviewCommentApi._internal();
  ReviewCommentApi._internal();
  static ReviewCommentApi get instance => _singleton;

  Future<ReviewCommentModel> comment({
    required String reviewId,
    required String commment,
    String? parentId,
  }) async {
    try {
      Map data = {"review_id": reviewId, "comment": commment};

      Response response = await postHttp(EndPoints.reviewComment(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return ReviewCommentModel.fromRawJson(json.encode(response.data));
        } catch (e) {
          return ReviewCommentModel();
        }
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
