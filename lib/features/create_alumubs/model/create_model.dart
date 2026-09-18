import 'dart:convert';

class CreateAlumbsModel {
    bool? success;
    String? message;
    Artist? artist;
    Experience? experience;
    int? festivalId;

    CreateAlumbsModel({
        this.success,
        this.message,
        this.artist,
        this.experience,
        this.festivalId,
    });

    CreateAlumbsModel copyWith({
        bool? success,
        String? message,
        Artist? artist,
        Experience? experience,
        int? festivalId,
    }) => 
        CreateAlumbsModel(
            success: success ?? this.success,
            message: message ?? this.message,
            artist: artist ?? this.artist,
            experience: experience ?? this.experience,
            festivalId: festivalId ?? this.festivalId,
        );

    factory CreateAlumbsModel.fromRawJson(String str) => CreateAlumbsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreateAlumbsModel.fromJson(Map<String, dynamic> json) => CreateAlumbsModel(
        success: json["success"],
        message: json["message"],
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
        experience: json["experience"] == null ? null : Experience.fromJson(json["experience"]),
        festivalId: json["festival_id"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "artist": artist?.toJson(),
        "experience": experience?.toJson(),
        "festival_id": festivalId,
    };
}

class Artist {
    int? userId;
    int? festivalId;
    dynamic name;
    String? image;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Artist({
        this.userId,
        this.festivalId,
        this.name,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    Artist copyWith({
        int? userId,
        int? festivalId,
        dynamic name,
        String? image,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        Artist(
            userId: userId ?? this.userId,
            festivalId: festivalId ?? this.festivalId,
            name: name ?? this.name,
            image: image ?? this.image,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory Artist.fromRawJson(String str) => Artist.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        userId: json["user_id"],
        festivalId: json["festival_id"],
        name: json["name"],
        image: json["image"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "festival_id": festivalId,
        "name": name,
        "image": image,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

class Experience {
    int? artistId;
    String? favouriteSet;
    String? favouriteDay;
    String? campExperience;
    String? festiveStory;
    dynamic festiveDate;
    String? locations;
    String? status;
    String? festType;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Experience({
        this.artistId,
        this.favouriteSet,
        this.favouriteDay,
        this.campExperience,
        this.festiveStory,
        this.festiveDate,
        this.locations,
        this.status,
        this.festType,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    Experience copyWith({
        int? artistId,
        String? favouriteSet,
        String? favouriteDay,
        String? campExperience,
        String? festiveStory,
        dynamic festiveDate,
        String? locations,
        String? status,
        String? festType,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        Experience(
            artistId: artistId ?? this.artistId,
            favouriteSet: favouriteSet ?? this.favouriteSet,
            favouriteDay: favouriteDay ?? this.favouriteDay,
            campExperience: campExperience ?? this.campExperience,
            festiveStory: festiveStory ?? this.festiveStory,
            festiveDate: festiveDate ?? this.festiveDate,
            locations: locations ?? this.locations,
            status: status ?? this.status,
            festType: festType ?? this.festType,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory Experience.fromRawJson(String str) => Experience.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        artistId: json["artist_id"],
        favouriteSet: json["favourite_set"],
        favouriteDay: json["favourite_day"],
        campExperience: json["camp_experience"],
        festiveStory: json["festive_story"],
        festiveDate: json["festive_date"],
        locations: json["locations"],
        status: json["status"],
        festType: json["fest_type"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "artist_id": artistId,
        "favourite_set": favouriteSet,
        "favourite_day": favouriteDay,
        "camp_experience": campExperience,
        "festive_story": festiveStory,
        "festive_date": festiveDate,
        "locations": locations,
        "status": status,
        "fest_type": festType,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
