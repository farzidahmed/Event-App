import 'dart:convert';

class LoginResponseModel {
    bool? status;
    String? message;
    int? code;
    String? tokenType;
    int? userId;
    String? token;
    int? expiresIn;

    LoginResponseModel({
        this.status,
        this.message,
        this.code,
        this.tokenType,
        this.userId,
        this.token,
        this.expiresIn,
    });

    LoginResponseModel copyWith({
        bool? status,
        String? message,
        int? code,
        String? tokenType,
        int? userId,
        String? token,
        int? expiresIn,
    }) => 
        LoginResponseModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            tokenType: tokenType ?? this.tokenType,
            userId: userId ?? this.userId,
            token: token ?? this.token,
            expiresIn: expiresIn ?? this.expiresIn,
        );

    factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        tokenType: json["token_type"],
        userId: json["user_id"],
        token: json["token"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "token_type": tokenType,
        "user_id": userId,
        "token": token,
        "expires_in": expiresIn,
    };
}
