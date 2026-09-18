import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:llr/features/create_alumubs/model/create_model.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class CreateAlumbsApi {
  static final CreateAlumbsApi _singleton = CreateAlumbsApi._internal();
  CreateAlumbsApi._internal();
  static CreateAlumbsApi get instance => _singleton;

  /// Convert HEIC/HEIF to JPEG if needed
  Future<File> convertToJpegIfNeeded(File file) async {
    final mimeType = lookupMimeType(file.path) ?? '';
    if (mimeType == 'image/heic' || mimeType == 'image/heif') {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) throw Exception("Failed to decode HEIC image");
      final jpegBytes = img.encodeJpg(image, quality: 90);
      final dir = await getTemporaryDirectory();
      final newPath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newFile = File(newPath);
      await newFile.writeAsBytes(jpegBytes);
      return newFile;
    }
    return file;
  }

  Future<CreateAlumbsModel> createPost({
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
  }) async {
    try {
      final formData = FormData();

      /// TEXT FIELDS
      formData.fields.addAll([
        MapEntry("favourite_set", favouriteSet),
        MapEntry("favourite_day", favouriteDay),
        MapEntry("description", description),
        MapEntry("day_type", dayType),
        MapEntry("festive_date", festiveDate),
        MapEntry("camp_experience", campExperience),
        MapEntry("festive_story", festiveStory),
        MapEntry("dairy_entry", dairyEntry),
        MapEntry("status", status ? "public" : "private"),
        MapEntry("fest_type", festType),
        MapEntry("festival_name", festivalName),
        MapEntry("festival_id", festivalId),
        MapEntry("locations", locations),
      ]);

      /// IMAGE (safe conversion)
      File imageFile = File(image.path);
      if (!await imageFile.exists() || await imageFile.length() == 0) {
        throw Exception("Image file does not exist or is empty: ${image.path}");
      }

      imageFile = await convertToJpegIfNeeded(imageFile);

      final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
      final splitMime = mimeType.split('/');

      formData.files.add(
        MapEntry(
          "image",
          await MultipartFile.fromFile(
            imageFile.path,
            filename: image.name,
            contentType: MediaType(splitMime[0], splitMime[1]),
          ),
        ),
      );

      /// CALL API
      final response = await postHttp(EndPoints.createAlumbs(), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateAlumbsModel.fromRawJson(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
