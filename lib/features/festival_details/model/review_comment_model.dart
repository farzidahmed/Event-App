import 'dart:convert';

class ReviewCommentModel {
    bool? status;
    String? message;
    Data? data;

    ReviewCommentModel({
        this.status,
        this.message,
        this.data,
    });

    ReviewCommentModel copyWith({
        bool? status,
        String? message,
        Data? data,
    }) => 
        ReviewCommentModel(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ReviewCommentModel.fromRawJson(String str) => ReviewCommentModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewCommentModel.fromJson(Map<String, dynamic> json) => ReviewCommentModel(
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
    int? reviewId;
    int? userId;
    String? comment;
    String? parentId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.reviewId,
        this.userId,
        this.comment,
        this.parentId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    Data copyWith({
        int? reviewId,
        int? userId,
        String? comment,
        String? parentId,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        Data(
            reviewId: reviewId ?? this.reviewId,
            userId: userId ?? this.userId,
            comment: comment ?? this.comment,
            parentId: parentId ?? this.parentId,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        reviewId: json["review_id"],
        userId: json["user_id"],
        comment: json["comment"],
        parentId: json["parent_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "user_id": userId,
        "comment": comment,
        "parent_id": parentId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
