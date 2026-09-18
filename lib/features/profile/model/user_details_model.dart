import 'dart:convert';

class UserDetailsModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  UserDetailsModel({this.status, this.message, this.code, this.data});

  UserDetailsModel copyWith({
    bool? status,
    String? message,
    int? code,
    Data? data,
  }) => UserDetailsModel(
    status: status ?? this.status,
    message: message ?? this.message,
    code: code ?? this.code,
    data: data ?? this.data,
  );

  factory UserDetailsModel.fromRawJson(String str) =>
      UserDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
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
  dynamic bio;
  String? country;
  String? sex;
  int? age;
  String? email;
  String? avatar;
  int? totalAlbums;
  int? totalFestables;
  int? days;
  int? states;
  List<WishlistItem>? wishlist;
  List<TopArtist>? topArtists;
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
    this.totalAlbums,
    this.totalFestables,
    this.days,
    this.states,
    this.wishlist,
    this.topArtists,
    this.isOnline,
    this.balance,
  });

  Data copyWith({
    int? id,
    String? name,
    String? username,
    String? slug,
    dynamic bio,
    String? country,
    String? sex,
    int? age,
    String? email,
    String? avatar,
    int? totalAlbums,
    int? totalFestables,
    int? days,
    int? states,
    List<WishlistItem>? wishlist,
    List<TopArtist>? topArtists,
    bool? isOnline,
    int? balance,
  }) => Data(
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
    totalAlbums: totalAlbums ?? this.totalAlbums,
    totalFestables: totalFestables ?? this.totalFestables,
    days: days ?? this.days,
    states: states ?? this.states,
    wishlist: wishlist ?? this.wishlist,
    topArtists: topArtists ?? this.topArtists,
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
    totalAlbums: json["total_albums"],
    totalFestables: json["total_festables"],
    days: json["days"],
    states: json["states"],
    wishlist:
        json["wishlist"] == null
            ? []
            : List<WishlistItem>.from(
              json["wishlist"]!.map((x) => WishlistItem.fromJson(x)),
            ),
    topArtists:
        json["top_artists"] == null
            ? []
            : List<TopArtist>.from(
              json["top_artists"]!.map((x) => TopArtist.fromJson(x)),
            ),
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
    "total_albums": totalAlbums,
    "total_festables": totalFestables,
    "days": days,
    "states": states,
    "wishlist":
        wishlist == null
            ? []
            : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
    "top_artists":
        topArtists == null
            ? []
            : List<dynamic>.from(topArtists!.map((x) => x.toJson())),
    "is_online": isOnline,
    "balance": balance,
  };
}

class TopArtist {
  int? id;
  int? userId;
  String? name;
  String? avatar;

  TopArtist({this.id, this.userId, this.name, this.avatar});

  TopArtist copyWith({int? id, int? userId, String? name, String? avatar}) =>
      TopArtist(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  factory TopArtist.fromRawJson(String str) =>
      TopArtist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopArtist.fromJson(Map<String, dynamic> json) => TopArtist(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "avatar": avatar,
  };
}

class WishlistItem {
  int? id;
  String? festivalName;
  String? avatar;
  String? locations;
  String? publishedAt;
  dynamic totalReview;

  WishlistItem({
    this.id,
    this.festivalName,
    this.avatar,
    this.locations,
    this.publishedAt,
    this.totalReview,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
    id: json["id"],
    festivalName: json["festival_name"],
    avatar: json["avatar"],
    locations: json["locations"],
    publishedAt: json["published_at"],
    totalReview: json["total_review"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "festival_name": festivalName,
    "avatar": avatar,
    "locations": locations,
    "published_at": publishedAt,
    "total_review": totalReview,
  };
}
