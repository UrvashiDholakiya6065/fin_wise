import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Model/user_model.dart';
import '../../../../Network/Repository/repository.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'conversation_id.dart';
import 'date_fromat.dart';

Widget chatItem(UserModel item, String currentUserId) {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(item.uid)
        .snapshots(),
    builder: (context, snapshot) {

      if (!snapshot.hasData) {
        return SizedBox();
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;
      bool isOnline = data['online'] ?? false;

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

                  Text(
                    isOnline ? "Online" : "Offline",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatTime(item.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),

                StreamBuilder<int>(
                  stream: Repository().getUnreadCount(
                    getConversationId(currentUserId, item.uid),
                    currentUserId,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == 0) {
                      return SizedBox();
                    }

                    return Container(
                      padding: const EdgeInsets.all(6),
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