import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/block/model/block_user_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class BlockUserApi {
  static final BlockUserApi _singleton = BlockUserApi._internal();
  BlockUserApi._internal();

  static BlockUserApi get instance => _singleton;

  Future<BlockUserModelResponse> blockUser() async {
    try {
      Response response = await getHttp(EndPoints.blockUser());
      if (response.statusCode == 200) {
        final data = BlockUserModelResponse.fromRawJson(
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
