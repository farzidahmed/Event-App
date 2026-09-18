import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/auth/presentation/update_profile_rx/api.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class EditProfileRx extends RxResponseInt<Map> {
  EditProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get getCartStream => dataFetcher.stream;
  final api = EditProfileApi.instance;

  Future<bool> editProfile({
    required String name,
    required String bio,
    required String sex,
    required String country,
    required String age,

    File? image,
  }) async {
    try {
      final data = await api.editProfile(
        image: image,
        name: name,
        bio: bio,
        sex: sex,
        country: country,
        age: age,
      );
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
        ToastUtil.showErrorMessage(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
