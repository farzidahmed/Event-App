import 'dart:convert';

class AllFestiveModel {
    bool? success;
    int? code;
    String? message;
    List<Datum>? data;

    AllFestiveModel({
        this.success,
        this.code,
        this.message,
        this.data,
    });

    AllFestiveModel copyWith({
        bool? success,
        int? code,
        String? message,
        List<Datum>? data,
    }) => 
        AllFestiveModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory AllFestiveModel.fromRawJson(String str) => AllFestiveModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllFestiveModel.fromJson(Map<String, dynamic> json) => AllFestiveModel(
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
    String? festivalName;
    String? image;

    Datum({
        this.id,
        this.festivalName,
        this.image,
    });

    Datum copyWith({
        int? id,
        String? festivalName,
        String? image,
    }) => 
        Datum(
            id: id ?? this.id,
            festivalName: festivalName ?? this.festivalName,
            image: image ?? this.image,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        festivalName: json["festival_name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "festival_name": festivalName,
        "image": image,
    };
}
