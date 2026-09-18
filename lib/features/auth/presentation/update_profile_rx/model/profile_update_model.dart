import 'dart:convert';

class GetProfileModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    GetProfileModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    GetProfileModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        GetProfileModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory GetProfileModel.fromRawJson(String str) => GetProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? username;
    String? slug;
    String? bio;
    String? country;
    String? sex;
    int? age;
    String? email;
    String? avatar;
    bool? isOnline;
    int? balance;

    Data({
        this.id,
        this.name,
        this.username,
        this.slug,
        this.bio,
        this.country,
        this.sex,
        this.age,
        this.email,
        this.avatar,
        this.isOnline,
        this.balance,
    });

    Data copyWith({
        int? id,
        String? name,
        String? username,
        String? slug,
        String? bio,
        String? country,
        String? sex,
        int? age,
        String? email,
        String? avatar,
        bool? isOnline,
        int? balance,
    }) => 
        Data(
            id: id ?? this.id,
            name: name ?? this.name,
            username: username ?? this.username,
            slug: slug ?? this.slug,
            bio: bio ?? this.bio,
            country: country ?? this.country,
            sex: sex ?? this.sex,
            age: age ?? this.age,
            email: email ?? this.email,
            avatar: avatar ?? this.avatar,
            isOnline: isOnline ?? this.isOnline,
            balance: balance ?? this.balance,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        slug: json["slug"],
        bio: json["bio"],
        country: json["country"],
        sex: json["sex"],
        age: json["age"],
        email: json["email"],
        avatar: json["avatar"],
        isOnline: json["is_online"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "slug": slug,
        "bio": bio,
        "country": country,
        "sex": sex,
        "age": age,
        "email": email,
        "avatar": avatar,
        "is_online": isOnline,
        "balance": balance,
    };
}
