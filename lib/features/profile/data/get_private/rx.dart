import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/profile/data/get_private/api.dart';
import 'package:llr/features/profile/model/private_albums_response.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../../networks/rx_base.dart';

final class GetPrivateAlbumsRx extends RxResponseInt<PrivetAlbumsResponse> {
  GetPrivateAlbumsRx({required super.empty, required super.dataFetcher});

  ValueStream get privateAlbumsStream => dataFetcher.stream;
  final api = GetPrivatestApi.instance;

  Future<bool> getPrivateAlbums() async {
    try {
      final data = await api.privateAlbums();
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        ToastUtil.showSuccessMessage(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
