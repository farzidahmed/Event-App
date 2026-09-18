import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/profile/model/public_albums_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class GetPublicAlbumsApi {
  static final GetPublicAlbumsApi _singleton = GetPublicAlbumsApi._internal();
  GetPublicAlbumsApi._internal();

  static GetPublicAlbumsApi get instance => _singleton;

  Future<PublicAlbumsResponse> publicAlbums() async {
    try {
      Response response = await getHttp(EndPoints.publicAlbums());
      if (response.statusCode == 200) {
        final data = PublicAlbumsResponse.fromRawJson(
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
