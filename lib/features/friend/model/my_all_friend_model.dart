import 'dart:convert';

class MyAllFriendModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  MyAllFriendModel({this.success, this.message, this.data, this.code});

  MyAllFriendModel copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) => MyAllFriendModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory MyAllFriendModel.fromRawJson(String str) =>
      MyAllFriendModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyAllFriendModel.fromJson(Map<String, dynamic> json) =>
      MyAllFriendModel(
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
  DateTime? friendSince;
  String? friendSinceHuman;

  Datum({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.friendSince,
    this.friendSinceHuman,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    DateTime? friendSince,
    String? friendSinceHuman,
  }) => Datum(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    friendSince: friendSince ?? this.friendSince,
    friendSinceHuman: friendSinceHuman ?? this.friendSinceHuman,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    friendSince:
        json["friend_since"] == null
            ? null
            : DateTime.parse(json["friend_since"]),
    friendSinceHuman: json["friend_since_human"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "friend_since": friendSince?.toIso8601String(),
    "friend_since_human": friendSinceHuman,
  };
}
