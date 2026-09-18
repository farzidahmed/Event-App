import 'dart:convert';

class SendChatModel {
    bool? success;
    String? message;
    Data? data;
    int? code;

    SendChatModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    SendChatModel copyWith({
        bool? success,
        String? message,
        Data? data,
        int? code,
    }) => 
        SendChatModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory SendChatModel.fromRawJson(String str) => SendChatModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SendChatModel.fromJson(Map<String, dynamic> json) => SendChatModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
    };
}

class Data {
    Chat? chat;

    Data({
        this.chat,
    });

    Data copyWith({
        Chat? chat,
    }) => 
        Data(
            chat: chat ?? this.chat,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
    );

    Map<String, dynamic> toJson() => {
        "chat": chat?.toJson(),
    };
}

class Chat {
    int? senderId;
    int? receiverId;
    dynamic text;
    dynamic file;
    int? roomId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;
    String? humanizeDate;
    dynamic shortText;
    String? type;
    Receiver? sender;
    Receiver? receiver;
    Room? room;

    Chat({
        this.senderId,
        this.receiverId,
        this.text,
        this.file,
        this.roomId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.humanizeDate,
        this.shortText,
        this.type,
        this.sender,
        this.receiver,
        this.room,
    });

    Chat copyWith({
        int? senderId,
        int? receiverId,
        dynamic text,
        dynamic file,
        int? roomId,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
        String? humanizeDate,
        dynamic shortText,
        String? type,
        Receiver? sender,
        Receiver? receiver,
        Room? room,
    }) => 
        Chat(
            senderId: senderId ?? this.senderId,
            receiverId: receiverId ?? this.receiverId,
            text: text ?? this.text,
            file: file ?? this.file,
            roomId: roomId ?? this.roomId,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
            humanizeDate: humanizeDate ?? this.humanizeDate,
            shortText: shortText ?? this.shortText,
            type: type ?? this.type,
            sender: sender ?? this.sender,
            receiver: receiver ?? this.receiver,
            room: room ?? this.room,
        );

    factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        text: json["text"],
        file: json["file"],
        roomId: json["room_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        humanizeDate: json["humanize_date"],
        shortText: json["short_text"],
        type: json["type"],
        sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
        room: json["room"] == null ? null : Room.fromJson(json["room"]),
    );

    Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "text": text,
        "file": file,
        "room_id": roomId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
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
    String? email;
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
        lastActivityAt: json["last_activity_at"] == null ? null : DateTime.parse(json["last_activity_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "last_activity_at": lastActivityAt?.toIso8601String(),
    };
}

class Room {
    int? id;
    int? userOneId;
    int? userTwoId;

    Room({
        this.id,
        this.userOneId,
        this.userTwoId,
    });

    Room copyWith({
        int? id,
        int? userOneId,
        int? userTwoId,
    }) => 
        Room(
            id: id ?? this.id,
            userOneId: userOneId ?? this.userOneId,
            userTwoId: userTwoId ?? this.userTwoId,
        );

    factory Room.fromRawJson(String str) => Room.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Room.fromJson(Map<String, dynamic> json) => Room(
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
