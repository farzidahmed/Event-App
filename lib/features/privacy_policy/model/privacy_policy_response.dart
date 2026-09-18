import 'dart:convert';

class PrivacyPolicyResponse {
  bool? status;
  String? message;
  Data? data;

  PrivacyPolicyResponse({this.status, this.message, this.data});

  PrivacyPolicyResponse copyWith({bool? status, String? message, Data? data}) =>
      PrivacyPolicyResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PrivacyPolicyResponse.fromRawJson(String str) =>
      PrivacyPolicyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? type;
  String? description;

  Data({this.id, this.type, this.description});

  Data copyWith({int? id, String? type, String? description}) => Data(
    id: id ?? this.id,
    type: type ?? this.type,
    description: description ?? this.description,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    type: json["type"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "description": description,
  };
}
