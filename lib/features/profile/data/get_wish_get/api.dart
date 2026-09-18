import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/profile/model/wish_list_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class GetWishListApi {
  static final GetWishListApi _singleton = GetWishListApi._internal();
  GetWishListApi._internal();

  static GetWishListApi get instance => _singleton;

  Future<WishResponse> wishList() async {
    try {
      Response response = await getHttp(EndPoints.wishList());
      if (response.statusCode == 200) {
        final data = WishResponse.fromRawJson(json.encode(response.data));
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
