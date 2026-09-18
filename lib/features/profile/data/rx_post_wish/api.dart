import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class PostWishApi {
  static final PostWishApi _singleton = PostWishApi._internal();
  PostWishApi._internal();

  static PostWishApi get instance => _singleton;

  Future<Map> postWish({required int id}) async {
    try {
      Response response = await postHttp(EndPoints.postWish(id));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
