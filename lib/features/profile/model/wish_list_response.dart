import 'dart:convert';

class WishResponse {
    bool? success;
    int? code;
    List<Datum>? data;

    WishResponse({
        this.success,
        this.code,
        this.data,
    });

    WishResponse copyWith({
        bool? success,
        int? code,
        List<Datum>? data,
    }) => 
        WishResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory WishResponse.fromRawJson(String str) => WishResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WishResponse.fromJson(Map<String, dynamic> json) => WishResponse(
        success: json["success"],
        code: json["code"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    int? artistId;
    String? artistImage;
    bool? isWishlisted;
    dynamic experience;
    List<dynamic>? documents;

    Datum({
        this.id,
        this.artistId,
        this.artistImage,
        this.isWishlisted,
        this.experience,
        this.documents,
    });

    Datum copyWith({
        int? id,
        int? artistId,
        String? artistImage,
        bool? isWishlisted,
        dynamic experience,
        List<dynamic>? documents,
    }) => 
        Datum(
            id: id ?? this.id,
            artistId: artistId ?? this.artistId,
            artistImage: artistImage ?? this.artistImage,
            isWishlisted: isWishlisted ?? this.isWishlisted,
            experience: experience ?? this.experience,
            documents: documents ?? this.documents,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        artistId: json["artist_id"],
        artistImage: json["artist_image"],
        isWishlisted: json["is_wishlisted"],
        experience: json["experience"],
        documents: json["documents"] == null ? [] : List<dynamic>.from(json["documents"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "artist_id": artistId,
        "artist_image": artistImage,
        "is_wishlisted": isWishlisted,
        "experience": experience,
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
    };
}
