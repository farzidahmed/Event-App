import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/features/create_alumubs/data/api.dart';
import 'package:llr/features/create_alumubs/model/create_model.dart';
import 'package:llr/helpers/toast.dart';

import '../../../../../../networks/rx_base.dart';

final class CreateAlumbsRx extends RxResponseInt<CreateAlumbsModel> {
  final api = CreateAlumbsApi.instance;

  CreateAlumbsRx({required super.empty, required super.dataFetcher});

  Future<bool> createPost({
    required String favouriteSet,
    required String favouriteDay,
    required String description,
    required String dayType,
    required String festiveDate,
    required String campExperience,
    required String festiveStory,
    required String dairyEntry,
    required bool status,
    required String festType,
    required XFile image,
    required String festivalName,
    required String festivalId,
    required String locations,
    // optional: required List<XFile> documents,
  }) async {
    try {
      final data = await api.createPost(
        favouriteSet: favouriteSet,
        favouriteDay: favouriteDay,
        description: description,
        dayType: dayType,
        festiveDate: festiveDate,
        campExperience: campExperience,
        festiveStory: festiveStory,
        dairyEntry: dairyEntry,
        status: status,
        festType: festType,
        image: image,
        festivalName: festivalName,
        festivalId: festivalId,
        locations: locations,
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
      if (error.response != null) {
        log("Dio error: ${error.response?.data}");
        ToastUtil.showErrorMessage(
          error.response?.data["message"] ?? "Failed to upload image",
        );
      }
    } else {
      log(error.toString());
      ToastUtil.showErrorMessage(error.toString());
    }
    dataFetcher.sink.addError(error);
    return false;
  }
}
