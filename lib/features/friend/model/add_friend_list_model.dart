import 'dart:convert';

class AddFriendListModel {
    bool? success;
    String? message;
    List<Datum>? data;
    int? code;

    AddFriendListModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    AddFriendListModel copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
        int? code,
    }) => 
        AddFriendListModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory AddFriendListModel.fromRawJson(String str) => AddFriendListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddFriendListModel.fromJson(Map<String, dynamic> json) => AddFriendListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
    };
}

class Datum {
    int? id;
    String? name;
    String? avatar;
    bool? isRequest;

    Datum({
        this.id,
        this.name,
        this.avatar,
        this.isRequest,
    });

    Datum copyWith({
        int? id,
        String? name,
        String? avatar,
        bool? isRequest,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
            isRequest: isRequest ?? this.isRequest,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        isRequest: json["is_request"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "is_request": isRequest,
    };
}
