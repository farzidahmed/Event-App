import 'dart:convert';

class AllAlumbsDetailsModel {
    bool? success;
    int? code;
    String? message;
    Data? data;

    AllAlumbsDetailsModel({
        this.success,
        this.code,
        this.message,
        this.data,
    });

    AllAlumbsDetailsModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        AllAlumbsDetailsModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory AllAlumbsDetailsModel.fromRawJson(String str) => AllAlumbsDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllAlumbsDetailsModel.fromJson(Map<String, dynamic> json) => AllAlumbsDetailsModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    int? artistId;
    String? artistName;
    String? festivalName;
    int? totalReview;
    String? artistImage;
    dynamic averageRating;
    String? publishedAt;
    Experience? experience;
    List<Document>? documents;
    List<dynamic>? reviews;

    Data({
        this.id,
        this.artistId,
        this.artistName,
        this.festivalName,
        this.totalReview,
        this.artistImage,
        this.averageRating,
        this.publishedAt,
        this.experience,
        this.documents,
        this.reviews,
    });

    Data copyWith({
        int? id,
        int? artistId,
        String? artistName,
        String? festivalName,
        int? totalReview,
        String? artistImage,
        dynamic averageRating,
        String? publishedAt,
        Experience? experience,
        List<Document>? documents,
        List<dynamic>? reviews,
    }) => 
        Data(
            id: id ?? this.id,
            artistId: artistId ?? this.artistId,
            artistName: artistName ?? this.artistName,
            festivalName: festivalName ?? this.festivalName,
            totalReview: totalReview ?? this.totalReview,
            artistImage: artistImage ?? this.artistImage,
            averageRating: averageRating ?? this.averageRating,
            publishedAt: publishedAt ?? this.publishedAt,
            experience: experience ?? this.experience,
            documents: documents ?? this.documents,
            reviews: reviews ?? this.reviews,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        artistId: json["artist_id"],
        artistName: json["artist_name"],
        festivalName: json["festival_name"],
        totalReview: json["total_review"],
        artistImage: json["artist_image"],
        averageRating: json["average_rating"],
        publishedAt: json["published_at"],
        experience: json["experience"] == null ? null : Experience.fromJson(json["experience"]),
        documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "artist_id": artistId,
        "artist_name": artistName,
        "festival_name": festivalName,
        "total_review": totalReview,
        "artist_image": artistImage,
        "average_rating": averageRating,
        "published_at": publishedAt,
        "experience": experience?.toJson(),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    };
}

class Document {
    int? id;
    String? fileUrl;

    Document({
        this.id,
        this.fileUrl,
    });

    Document copyWith({
        int? id,
        String? fileUrl,
    }) => 
        Document(
            id: id ?? this.id,
            fileUrl: fileUrl ?? this.fileUrl,
        );

    factory Document.fromRawJson(String str) => Document.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        fileUrl: json["file_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "file_url": fileUrl,
    };
}

class Experience {
    int? id;
    String? favouriteSet;
    String? favouriteDay;
    String? campExperience;
    String? festiveStory;
    DateTime? festiveDate;
    String? status;
    String? festType;
    String? location;

    Experience({
        this.id,
        this.favouriteSet,
        this.favouriteDay,
        this.campExperience,
        this.festiveStory,
        this.festiveDate,
        this.status,
        this.festType,
        this.location,
    });

    Experience copyWith({
        int? id,
        String? favouriteSet,
        String? favouriteDay,
        String? campExperience,
        String? festiveStory,
        DateTime? festiveDate,
        String? status,
        String? festType,
        String? location,
    }) => 
        Experience(
            id: id ?? this.id,
            favouriteSet: favouriteSet ?? this.favouriteSet,
            favouriteDay: favouriteDay ?? this.favouriteDay,
            campExperience: campExperience ?? this.campExperience,
            festiveStory: festiveStory ?? this.festiveStory,
            festiveDate: festiveDate ?? this.festiveDate,
            status: status ?? this.status,
            festType: festType ?? this.festType,
            location: location ?? this.location,
        );

    factory Experience.fromRawJson(String str) => Experience.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        favouriteSet: json["favourite_set"],
        favouriteDay: json["favourite_day"],
        campExperience: json["camp_experience"],
        festiveStory: json["festive_story"],
        festiveDate: json["festive_date"] == null ? null : DateTime.parse(json["festive_date"]),
        status: json["status"],
        festType: json["fest_type"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "favourite_set": favouriteSet,
        "favourite_day": favouriteDay,
        "camp_experience": campExperience,
        "festive_story": festiveStory,
        "festive_date": festiveDate == null ? null : "${festiveDate!.year.toString().padLeft(4, '0')}-${festiveDate!.month.toString().padLeft(2, '0')}-${festiveDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "fest_type": festType,
        "location": location,
    };
}
