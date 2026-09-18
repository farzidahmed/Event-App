import 'dart:convert';

class BlockUserModelResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  BlockUserModelResponse({this.success, this.message, this.data, this.code});

  BlockUserModelResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) => BlockUserModelResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory BlockUserModelResponse.fromRawJson(String str) =>
      BlockUserModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockUserModelResponse.fromJson(Map<String, dynamic> json) =>
      BlockUserModelResponse(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code,
  };
}

class Datum {
  int? id;
  String? name;
  String? email;
  String? avatar;

  Datum({this.id, this.name, this.email, this.avatar});

  Datum copyWith({int? id, String? name, String? email, String? avatar}) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
  };
}
