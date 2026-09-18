import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/profile/model/private_albums_response.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class GetPrivatestApi {
  static final GetPrivatestApi _singleton = GetPrivatestApi._internal();
  GetPrivatestApi._internal();

  static GetPrivatestApi get instance => _singleton;

  Future<PrivetAlbumsResponse> privateAlbums() async {
    try {
      Response response = await getHttp(EndPoints.privateAlbums());
      if (response.statusCode == 200) {
        final data = PrivetAlbumsResponse.fromRawJson(
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
