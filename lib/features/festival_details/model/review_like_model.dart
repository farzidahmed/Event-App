import 'dart:convert';

class ReviewModelLike {
    bool? status;
    String? message;
    Data? data;

    ReviewModelLike({
        this.status,
        this.message,
        this.data,
    });

    ReviewModelLike copyWith({
        bool? status,
        String? message,
        Data? data,
    }) => 
        ReviewModelLike(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ReviewModelLike.fromRawJson(String str) => ReviewModelLike.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewModelLike.fromJson(Map<String, dynamic> json) => ReviewModelLike(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? artistId;
    int? userId;
    String? rating;
    String? comment;
    int? id;

    Data({
        this.artistId,
        this.userId,
        this.rating,
        this.comment,
        this.id,
    });

    Data copyWith({
        String? artistId,
        int? userId,
        String? rating,
        String? comment,
        int? id,
    }) => 
        Data(
            artistId: artistId ?? this.artistId,
            userId: userId ?? this.userId,
            rating: rating ?? this.rating,
            comment: comment ?? this.comment,
            id: id ?? this.id,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        artistId: json["artist_id"],
        userId: json["user_id"],
        rating: json["rating"],
        comment: json["comment"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "artist_id": artistId,
        "user_id": userId,
        "rating": rating,
        "comment": comment,
        "id": id,
    };
}
