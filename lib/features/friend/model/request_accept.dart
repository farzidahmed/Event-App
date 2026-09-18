import 'dart:convert';

class AcceptModel {
    bool? success;
    String? message;
    List<dynamic>? data;
    int? code;

    AcceptModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    AcceptModel copyWith({
        bool? success,
        String? message,
        List<dynamic>? data,
        int? code,
    }) => 
        AcceptModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory AcceptModel.fromRawJson(String str) => AcceptModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AcceptModel.fromJson(Map<String, dynamic> json) => AcceptModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "code": code,
    };
}
