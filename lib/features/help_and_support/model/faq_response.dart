import 'dart:convert';

class FaqResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  FaqResponse({this.success, this.message, this.data, this.code});

  FaqResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) => FaqResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory FaqResponse.fromRawJson(String str) =>
      FaqResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
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
  String? question;
  String? answer;
  String? status;

  Datum({this.id, this.question, this.answer, this.status});

  Datum copyWith({int? id, String? question, String? answer, String? status}) =>
      Datum(
        id: id ?? this.id,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        status: status ?? this.status,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "status": status,
  };
}
