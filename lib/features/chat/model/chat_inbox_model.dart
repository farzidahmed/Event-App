import 'dart:convert';

class ChatInboxModel {
  bool? success;
  String? message;
  ChatDataModel? data;
  int? code;

  ChatInboxModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  ChatInboxModel copyWith({
    bool? success,
    String? message,
    ChatDataModel? data,
    int? code,
  }) =>
      ChatInboxModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory ChatInboxModel.fromRawJson(String str) =>
      ChatInboxModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatInboxModel.fromJson(Map<String, dynamic> json) => ChatInboxModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ChatDataModel.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class ChatDataModel {
  Receiver? receiver;
  Receiver? sender;
  DataRoom? room;
  Chat? chat;

  ChatDataModel({
    this.receiver,
    this.sender,
    this.room,
    this.chat,
  });

  ChatDataModel copyWith({
    Receiver? receiver,
    Receiver? sender,
    DataRoom? room,
    Chat? chat,
  }) =>
      ChatDataModel(
        receiver: receiver ?? this.receiver,
        sender: sender ?? this.sender,
        room: room ?? this.room,
        chat: chat ?? this.chat,
      );

  factory ChatDataModel.fromRawJson(String str) =>
      ChatDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatDataModel.fromJson(Map<String, dynamic> json) => ChatDataModel(
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
        sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        room: json["room"] == null ? null : DataRoom.fromJson(json["room"]),
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
      );

  Map<String, dynamic> toJson() => {
        "receiver": receiver?.toJson(),
        "sender": sender?.toJson(),
        "room": room?.toJson(),
        "chat": chat?.toJson(),
      };
}

class Chat {
  int? currentPage;
  List<ChatData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Chat({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Chat copyWith({
    int? currentPage,
    List<ChatData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Chat(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ChatData>.from(json["data"]!.map((x) => ChatData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ChatData {
  int? id;
  int? senderId;
  int? receiverId;
  int? roomId;
  String? text;
  dynamic file;
  String? status; // Changed from enum
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? humanizeDate; // Changed from enum
  String? shortText;
  String? type; // Changed from enum
  Receiver? sender;
  Receiver? receiver;
  DatumRoom? room;

  ChatData({
    this.id,
    this.senderId,
    this.receiverId,
    this.roomId,
    this.text,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.humanizeDate,
    this.shortText,
    this.type,
    this.sender,
    this.receiver,
    this.room,
  });

  ChatData copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    int? roomId,
    String? text,
    dynamic file,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? humanizeDate,
    String? shortText,
    String? type,
    Receiver? sender,
    Receiver? receiver,
    DatumRoom? room,
  }) =>
      ChatData(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        roomId: roomId ?? this.roomId,
        text: text ?? this.text,
        file: file ?? this.file,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        humanizeDate: humanizeDate ?? this.humanizeDate,
        shortText: shortText ?? this.shortText,
        type: type ?? this.type,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        room: room ?? this.room,
      );

  factory ChatData.fromRawJson(String str) => ChatData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        roomId: json["room_id"],
        text: json["text"],
        file: json["file"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        humanizeDate: json["humanize_date"],
        shortText: json["short_text"],
        type: json["type"],
        sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
        room: json["room"] == null ? null : DatumRoom.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "room_id": roomId,
        "text": text,
        "file": file,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "humanize_date": humanizeDate,
        "short_text": shortText,
        "type": type,
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "room": room?.toJson(),
      };
}

class Receiver {
  int? id;
  dynamic name;
  String? email; // Changed from enum
  dynamic avatar;
  DateTime? lastActivityAt;

  Receiver({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.lastActivityAt,
  });

  Receiver copyWith({
    int? id,
    dynamic name,
    String? email,
    dynamic avatar,
    DateTime? lastActivityAt,
  }) =>
      Receiver(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      );

  factory Receiver.fromRawJson(String str) => Receiver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        lastActivityAt:
            json["last_activity_at"] == null ? null : DateTime.parse(json["last_activity_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "last_activity_at": lastActivityAt?.toIso8601String(),
      };
}

class DatumRoom {
  int? id;
  int? userOneId;
  int? userTwoId;

  DatumRoom({
    this.id,
    this.userOneId,
    this.userTwoId,
  });

  DatumRoom copyWith({
    int? id,
    int? userOneId,
    int? userTwoId,
  }) =>
      DatumRoom(
        id: id ?? this.id,
        userOneId: userOneId ?? this.userOneId,
        userTwoId: userTwoId ?? this.userTwoId,
      );

  factory DatumRoom.fromRawJson(String str) => DatumRoom.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumRoom.fromJson(Map<String, dynamic> json) => DatumRoom(
        id: json["id"],
        userOneId: json["user_one_id"],
        userTwoId: json["user_two_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_one_id": userOneId,
        "user_two_id": userTwoId,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class DataRoom {
  int? id;
  int? userOneId;
  int? userTwoId;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataRoom({
    this.id,
    this.userOneId,
    this.userTwoId,
    this.createdAt,
    this.updatedAt,
  });

  DataRoom copyWith({
    int? id,
    int? userOneId,
    int? userTwoId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DataRoom(
        id: id ?? this.id,
        userOneId: userOneId ?? this.userOneId,
        userTwoId: userTwoId ?? this.userTwoId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataRoom.fromRawJson(String str) => DataRoom.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRoom.fromJson(Map<String, dynamic> json) => DataRoom(
        id: json["id"],
        userOneId: json["user_one_id"],
        userTwoId: json["user_two_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_one_id": userOneId,
        "user_two_id": userTwoId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
