

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../Model/user_model.dart';
import '../../../../Network/Repository/repository.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'conversation_id.dart';

String formatTime(DateTime time) {
  final now = DateTime.now();

  if (now.difference(time).inDays == 0) {
    int hour = time.hour > 12 ? time.hour - 12 : time.hour;
    hour = hour == 0 ? 12 : hour;
    String amPm = time.hour >= 12 ? "PM" : "AM";

    return "$hour:${time.minute.toString().padLeft(2, '0')} $amPm";
  } else if (now.difference(time).inDays == 1) {
    return "Yesterday";
  } else {
    return "${time.day}/${time.month}";
  }
}

Widget chatItem(UserModel item, String currentUserId) {
  final conversationId = getConversationId(currentUserId, item.uid);

  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(item.uid)
        .snapshots(),
    builder: (context, userSnap) {
      if (!userSnap.hasData) return SizedBox();

      final userData = userSnap.data!.data() as Map<String, dynamic>;
      bool isOnline = userData['online'] ?? false;

      return Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  child: Text(item.fullName[0]),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),

                    StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('conversations')
                        .doc(conversationId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          !snapshot.data!.exists) {
                        return Text(
                          "No messages yet",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey),
                        );
                      }

                      final data =
                      snapshot.data!.data() as Map<String, dynamic>;

                      String message = data['lastMessage'] ?? '';
                      String senderId = data['lastSenderId'] ?? '';

                      return Text(
                        senderId == currentUserId
                            ? "You: $message"
                            : message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('conversations')
                      .doc(conversationId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        !snapshot.data!.exists) {
                      return SizedBox();
                    }

                    final data =
                    snapshot.data!.data() as Map<String, dynamic>;

                    final timestamp = data['lastMessageTime'];
                    String senderId = data['lastSenderId'] ?? '';

                    if (timestamp == null) return SizedBox();

                    DateTime time =
                    (timestamp as Timestamp).toDate();

                    return Column(
                      children: [
                        Text(
                          formatTime(time),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        if (senderId == currentUserId)
                          Icon(
                            data['lastMessageRead'] == true
                                ? Icons.done_all
                                : Icons.done,
                            size: 16,
                            color: data['lastMessageRead'] == true
                                ? Colors.blue
                                : Colors.grey,
                          ),

                      ],
                    );
                  },
                ),

                SizedBox(height: 6),

                StreamBuilder<int>(
                  stream: Repository().getUnreadCount(
                    conversationId,
                    currentUserId,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == 0) {
                      return SizedBox();
                    }

                    return Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: ColorsWidgets.mainAppColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}