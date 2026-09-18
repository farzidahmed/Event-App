import 'dart:convert';

class MyAlumbsModel {
    bool? success;
    int? code;
    String? message;
    List<Datum>? data;

    MyAlumbsModel({
        this.success,
        this.code,
        this.message,
        this.data,
    });

    MyAlumbsModel copyWith({
        bool? success,
        int? code,
        String? message,
        List<Datum>? data,
    }) => 
        MyAlumbsModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory MyAlumbsModel.fromRawJson(String str) => MyAlumbsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MyAlumbsModel.fromJson(Map<String, dynamic> json) => MyAlumbsModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? type;
    String? festivalName;
    int? totalReview;
    dynamic locations;
    String? artistImage;
    double? averageRating;
    String? publishedAt;
    int? totalImages;
    int? totalVideos;

    Datum({
        this.id,
        this.type,
        this.festivalName,
        this.totalReview,
        this.locations,
        this.artistImage,
        this.averageRating,
        this.publishedAt,
        this.totalImages,
        this.totalVideos,
    });

    Datum copyWith({
        int? id,
        String? type,
        String? festivalName,
        int? totalReview,
        dynamic locations,
        String? artistImage,
        double? averageRating,
        String? publishedAt,
        int? totalImages,
        int? totalVideos,
    }) => 
        Datum(
            id: id ?? this.id,
            type: type ?? this.type,
            festivalName: festivalName ?? this.festivalName,
            totalReview: totalReview ?? this.totalReview,
            locations: locations ?? this.locations,
            artistImage: artistImage ?? this.artistImage,
            averageRating: averageRating ?? this.averageRating,
            publishedAt: publishedAt ?? this.publishedAt,
            totalImages: totalImages ?? this.totalImages,
            totalVideos: totalVideos ?? this.totalVideos,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        festivalName: json["festival_name"],
        totalReview: json["total_review"],
        locations: json["locations"],
        artistImage: json["artist_image"],
        averageRating: json["average_rating"]?.toDouble(),
        publishedAt: json["published_at"],
        totalImages: json["total_images"],
        totalVideos: json["total_videos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "festival_name": festivalName,
        "total_review": totalReview,
        "locations": locations,
        "artist_image": artistImage,
        "average_rating": averageRating,
        "published_at": publishedAt,
        "total_images": totalImages,
        "total_videos": totalVideos,
    };
}
