import 'dart:convert';

class SearchFestivalResponse {
  bool? success;
  int? code;
  String? message;
  List<Datum>? data;

  SearchFestivalResponse({this.success, this.code, this.message, this.data});

  SearchFestivalResponse copyWith({
    bool? success,
    int? code,
    String? message,
    List<Datum>? data,
  }) => SearchFestivalResponse(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory SearchFestivalResponse.fromRawJson(String str) =>
      SearchFestivalResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFestivalResponse.fromJson(Map<String, dynamic> json) =>
      SearchFestivalResponse(
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
  String? festivalName;
  String? image;
  String? location;
  DateTime? startDate;
  DateTime? endDate;

  Datum({
    this.id,
    this.festivalName,
    this.image,
    this.location,
    this.startDate,
    this.endDate,
  });

  Datum copyWith({
    int? id,
    String? festivalName,
    String? image,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
  }) => Datum(
    id: id ?? this.id,
    festivalName: festivalName ?? this.festivalName,
    image: image ?? this.image,
    location: location ?? this.location,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    festivalName: json["festival_name"],
    image: json["image"],
    location: json["location"],
    startDate:
        json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "festival_name": festivalName,
    "image": image,
    "location": location,
    "start_date":
        "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date":
        "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
  };
}
