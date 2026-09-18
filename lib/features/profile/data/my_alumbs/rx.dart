import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:llr/features/profile/data/my_alumbs/api.dart';
import 'package:llr/features/profile/model/my_alumbs_model.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/stream_cleaner.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../networks/rx_base.dart';

final class MyAlumbsRx extends RxResponseInt<MyAlumbsModel> {
  MyAlumbsRx({required super.empty, required super.dataFetcher});

  // Separate fetchers for each album type
  final _allAlbumsFetcher = BehaviorSubject<MyAlumbsModel>();
  final _publicAlbumsFetcher = BehaviorSubject<MyAlumbsModel>();
  final _privateAlbumsFetcher = BehaviorSubject<MyAlumbsModel>();

  // Exposing as streams
  ValueStream<MyAlumbsModel> get allAlbumsStream => _allAlbumsFetcher.stream;
  ValueStream<MyAlumbsModel> get publicAlbumsStream =>
      _publicAlbumsFetcher.stream;
  ValueStream<MyAlumbsModel> get privateAlbumsStream =>
      _privateAlbumsFetcher.stream;

  final api = MyAlumbsApi.instance;

  Future<MyAlumbsModel> myAlumbs(int type) async {
    try {
      final data = await api.myAlumbs(type);

      // Sink data into the appropriate fetcher based on type
      if (type == 0) {
        _allAlbumsFetcher.sink.add(data);
      } else if (type == 1) {
        _publicAlbumsFetcher.sink.add(data);
      } else if (type == 2) {
        _privateAlbumsFetcher.sink.add(data);
      }

      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        totalDataClean();
        //appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
      } else {
        ToastUtil.showErrorMessage(
          error.response?.data["message"] ?? "Something went wrong",
        );
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);

    // Add error to specialized fetchers as well
    _allAlbumsFetcher.sink.addError(error);
    _publicAlbumsFetcher.sink.addError(error);
    _privateAlbumsFetcher.sink.addError(error);

    // throw error;
    return false;
  }

  @override
  void clean() {
    _allAlbumsFetcher.sink.add(empty);
    _publicAlbumsFetcher.sink.add(empty);
    _privateAlbumsFetcher.sink.add(empty);
    super.clean();
  }
}
