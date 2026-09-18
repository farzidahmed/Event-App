import 'dart:convert';

class UserListModel {
    bool? success;
    String? message;
    Data? data;

    UserListModel({
        this.success,
        this.message,
        this.data,
    });

    UserListModel copyWith({
        bool? success,
        String? message,
        Data? data,
    }) => 
        UserListModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory UserListModel.fromRawJson(String str) => UserListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    List<User>? users;

    Data({
        this.users,
    });

    Data copyWith({
        List<User>? users,
    }) => 
        Data(
            users: users ?? this.users,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    dynamic avatar;
    DateTime? lastActivityAt;
    LastChat? lastChat;
    bool? isOnline;
    int? balance;

    User({
        this.id,
        this.name,
        this.email,
        this.avatar,
        this.lastActivityAt,
        this.lastChat,
        this.isOnline,
        this.balance,
    });

    User copyWith({
        int? id,
        String? name,
        String? email,
        dynamic avatar,
        DateTime? lastActivityAt,
        LastChat? lastChat,
        bool? isOnline,
        int? balance,
    }) => 
        User(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            avatar: avatar ?? this.avatar,
            lastActivityAt: lastActivityAt ?? this.lastActivityAt,
            lastChat: lastChat ?? this.lastChat,
            isOnline: isOnline ?? this.isOnline,
            balance: balance ?? this.balance,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        lastActivityAt: json["last_activity_at"] == null ? null : DateTime.parse(json["last_activity_at"]),
        lastChat: json["last_chat"] == null ? null : LastChat.fromJson(json["last_chat"]),
        isOnline: json["is_online"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "last_activity_at": lastActivityAt?.toIso8601String(),
        "last_chat": lastChat?.toJson(),
        "is_online": isOnline,
        "balance": balance,
    };
}

class LastChat {
    int? id;
    int? senderId;
    int? receiverId;
    int? roomId;
    String? text;
    dynamic file;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? humanizeDate;
    String? shortText;
    String? type;

    LastChat({
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
    });

    LastChat copyWith({
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
    }) => 
        LastChat(
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
        );

    factory LastChat.fromRawJson(String str) => LastChat.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastChat.fromJson(Map<String, dynamic> json) => LastChat(
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
    };
}
