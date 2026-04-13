class ChatModel {
  final String? id;
  final String? msg;
  final bool isMe;
  final DateTime time;
  final bool isRead;
  final String? imagePath;
  final String? filePath;
  final String? senderId;
  final String? receiverId;
  String? replyMessage;
  String? replySenderId;
  String? reaction;
  final String? status;
  final bool isEdited;
  final DateTime? lastSeen;
  String? replyMessageId;


  ChatModel({
    this.id,

    this.msg,
    required this.isMe,
    required this.time,
    required this.isRead,
    this.imagePath,
    this.filePath,
    required this.senderId,
    required this.receiverId,
    this.replyMessage,
    this.replySenderId,
    this.reaction,
    this.isEdited = false,
    this.status,
    this.lastSeen,
    this.replyMessageId,

  });

  ChatModel copyWith({
    String? id,
    String? msg,
    bool? isMe,
    DateTime? time,
    bool? isRead,
    String? imagePath,
    String? filePath,
    String? senderId,
    String? receiverId,
    String? replyMessage,
    String? replySenderId,
    String? reaction,

    bool? isEdited,
    String? status,
     DateTime? lastSeen,
    String? replyMessageId,

  }) {
    return ChatModel(      id: id ?? this.id,


        msg: msg ?? this.msg,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      imagePath: imagePath ?? this.imagePath,
      filePath: filePath ?? this.filePath,
      senderId: senderId??this.senderId,
      receiverId: receiverId??this.receiverId,
      replyMessage: replyMessage??this.replyMessage,
      replySenderId: replySenderId??this.replySenderId,
      reaction: reaction??this.reaction,
      isEdited: isEdited ?? this.isEdited,
      status: status??this.status,
      lastSeen: lastSeen??this.lastSeen,
      replyMessageId: replyMessageId??this.replyMessageId
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "msg": msg,
      "isMe": isMe,
      "time": time.toIso8601String(),
      "isRead": isRead,
      "imagePath": imagePath,
      "filePath": filePath,
      "senderId":senderId,
      "receiverId":receiverId,
      "replyMessage":replyMessage,
      "replySenderId":replySenderId,
      "reaction":reaction,
      "id":id,
      "status":status,
      "lastSeen":lastSeen,
      "replyMessageId":replyMessageId,
      "isEdited": isEdited,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json,String id) {
    return ChatModel(
        msg: json["msg"] ?? "",
        isMe: json["isMe"] ?? false,
        time: DateTime.parse(json["time"]),
        isRead: json["isRead"] ?? false,
        imagePath: json["imagePath"],
        filePath: json["filePath"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        replyMessage: json["replyMessage"],
        replySenderId: json["replySenderId"],
        reaction: json["reaction"],
        status: json["status"],
        id: id,
      lastSeen: json["lastSeen"],
        replyMessageId:json["replyMessageId"],
      isEdited: json["isEdited"] ?? false, // ✅ ADD THIS

    );
  }
}