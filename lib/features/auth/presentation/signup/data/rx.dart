// // ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:oscaru95/constants/app_constants.dart';
// import 'package:oscaru95/features/auth/signup/data/api.dart';
// import 'package:oscaru95/features/auth/signup/model/sign_up_model.dart';
// import 'package:oscaru95/helpers/di.dart';
// import 'package:oscaru95/networks/dio/dio.dart';
// import 'package:oscaru95/networks/rx_base.dart';

// import 'package:rxdart/rxdart.dart';

// final class SignupRX extends RxResponseInt {
//   final api = SignupApi.instance;
//   SignupRX({required super.empty, required super.dataFetcher});
//   ValueStream get getFileData => dataFetcher.stream;

//   Future<bool> signup({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String confirmPass,
//   }) async {
//     try {
//       Map data = await api.signup(
//       firatName: firstName,
//       lastName: lastName,
//       email: email,
//       password: password,
//       confirmPass: confirmPass
//       );
//       return await handleSuccessWithReturn(data);
//     } catch (error) {
//       return await handleErrorWithReturn(error);
//     }
//   }

//  @override
//   handleSuccessWithReturn(data) async {
//     if (data is! SignUpResponseModel) return false;

//     await appData.write(kKeyAccessToken, token);
//     await appData.write(kKeyIsLoggedIn, true);

//     DioSingleton.instance.update(token);
//     log("Signup success, token updated");

//     return true;
//   }

//   @override
//   handleErrorWithReturn(error) {
//     if (error is DioException) {
//       log('DioException: ${error.message}');
//     } else {
//       log('Unexpected error: ${error.runtimeType} - ${error.toString()}');
//     }

//     dataFetcher.sink.addError(error);
//     return false;
//   }
// }
// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/constants/app_constants.dart';
import 'package:llr/features/auth/presentation/signup/data/api.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/di.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/rx_base.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

final class SignupRX extends RxResponseInt {
  final api = SignupApi.instance;
  SignupRX({required super.empty, required super.dataFetcher});
  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPass,
  }) async {
    try {
      Map data = await api.signup(
        name: name,
        email: email,
        password: password,
        confirmPass: confirmPass,
      );
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    log('message');
    // ignore: unused_local_variable
    Map response = data;

    return true;
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      if (error.response != null && error.response!.statusCode == 422) {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showLongToast(errorMessage);
      } else if (error.response!.statusCode == 404) {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";

        ToastUtil.showLongToast(errorMessage);
      } else if (error.response!.statusCode == 401) {
        ToastUtil.showLongToast("Unauthenticate Login again.");
        await appData.write(kKeyIsLoggedIn, false);
        totalDataClean();
        NavigationService.popAndReplace(Routes.loginScreen);
      } else if (error.response!.statusCode == 400) {
        ToastUtil.showLongToast("user with this email already exist");
      } else {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showLongToast(errorMessage);
      }
    } else {
      log("Error ====> $error");
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    throw error;
  }
}
