import 'dart:convert';

class PublicAlbumsResponse {
  bool? success;
  int? code;
  String? message;
  List<Datum>? data;

  PublicAlbumsResponse({this.success, this.code, this.message, this.data});

  PublicAlbumsResponse copyWith({
    bool? success,
    int? code,
    String? message,
    List<Datum>? data,
  }) => PublicAlbumsResponse(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory PublicAlbumsResponse.fromRawJson(String str) =>
      PublicAlbumsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PublicAlbumsResponse.fromJson(Map<String, dynamic> json) =>
      PublicAlbumsResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  dynamic artistName;
  int? artistId;
  String? type;
  String? festivalName;
  int? totalReview;
  String? locations;
  String? artistImage;
  dynamic averageRating;
  String? publishedAt;
  int? totalImages;
  int? totalVideos;
  bool? isFavorite;

  Datum({
    this.id,
    this.artistName,
    this.artistId,
    this.type,
    this.festivalName,
    this.totalReview,
    this.locations,
    this.artistImage,
    this.averageRating,
    this.publishedAt,
    this.totalImages,
    this.totalVideos,
    this.isFavorite,
  });

  Datum copyWith({
    int? id,
    dynamic artistName,
    int? artistId,
    String? type,
    String? festivalName,
    int? totalReview,
    String? locations,
    String? artistImage,
    dynamic averageRating,
    String? publishedAt,
    int? totalImages,
    int? totalVideos,
    bool? isFavorite,
  }) => Datum(
    id: id ?? this.id,
    artistName: artistName ?? this.artistName,
    artistId: artistId ?? this.artistId,
    type: type ?? this.type,
    festivalName: festivalName ?? this.festivalName,
    totalReview: totalReview ?? this.totalReview,
    locations: locations ?? this.locations,
    artistImage: artistImage ?? this.artistImage,
    averageRating: averageRating ?? this.averageRating,
    publishedAt: publishedAt ?? this.publishedAt,
    totalImages: totalImages ?? this.totalImages,
    totalVideos: totalVideos ?? this.totalVideos,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    artistName: json["artist_name"],
    artistId: json["artist_id"],
    type: json["type"],
    festivalName: json["festival_name"],
    totalReview: json["total_review"],
    locations: json["locations"],
    artistImage: json["artist_image"],
    averageRating: json["average_rating"],
    publishedAt: json["published_at"],
    totalImages: json["total_images"],
    totalVideos: json["total_videos"],
    isFavorite: json["is_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "artist_name": artistName,
    "artist_id": artistId,
    "type": type,
    "festival_name": festivalName,
    "total_review": totalReview,
    "locations": locations,
    "artist_image": artistImage,
    "average_rating": averageRating,
    "published_at": publishedAt,
    "total_images": totalImages,
    "total_videos": totalVideos,
    "is_favorite": isFavorite,
  };
}
