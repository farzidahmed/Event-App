import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class ContactMessageApi {
  static final ContactMessageApi _singleton = ContactMessageApi._internal();
  ContactMessageApi._internal();

  static ContactMessageApi get instance => _singleton;

  Future<Map> sendMessage({required String message}) async {
    try {
      FormData data = FormData.fromMap({"message": message});
      Response response = await postHttp(EndPoints.contactMessage(), data);

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
