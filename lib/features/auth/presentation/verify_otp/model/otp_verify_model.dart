import 'dart:convert';

class VerfiyOtpModel {
    bool? status;
    String? message;
    int? code;
    String? token;

    VerfiyOtpModel({
        this.status,
        this.message,
        this.code,
        this.token,
    });

    VerfiyOtpModel copyWith({
        bool? status,
        String? message,
        int? code,
        String? token,
    }) => 
        VerfiyOtpModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            token: token ?? this.token,
        );

    factory VerfiyOtpModel.fromRawJson(String str) => VerfiyOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VerfiyOtpModel.fromJson(Map<String, dynamic> json) => VerfiyOtpModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "token": token,
    };
}
