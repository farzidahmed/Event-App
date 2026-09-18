import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:llr/features/chat/model/send_model.dart';
import 'package:llr/networks/dio/dio.dart';
import 'package:llr/networks/endpoints.dart';
import 'package:llr/networks/exception_handler/data_source.dart';

final class SendMessageApi {
  static final SendMessageApi _singleton = SendMessageApi._internal();
  SendMessageApi._internal();
  static SendMessageApi get instance => _singleton;

  Future<SendChatModel> sendMessage({
    required int id,
    required String message,
    String? filePath,
  }) async {
    try {
      Map<String, dynamic> dataMap = {'text': message};

      if (filePath != null && filePath.isNotEmpty) {
        dataMap['file'] = await MultipartFile.fromFile(filePath);
      }

      var data = FormData.fromMap(dataMap);

      Response response = await postHttp(EndPoints.sendMessage(id), data);
      if (response.statusCode == 200) {
        final data = SendChatModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
