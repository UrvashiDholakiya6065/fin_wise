import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/ChatBloc/chat_bloc.dart';
import '../../../../Bloc/ChatBloc/chat_event.dart';
import '../../../../Model/chat_model.dart';
import 'conversation_id.dart';

Widget emojiItem(String emoji, ChatModel msg,  BuildContext parentContext,
    BuildContext dialogContext,) {
  return GestureDetector(
    onTap: () async {
      await FirebaseFirestore.instance
          .collection("conversations")
          .doc(getConversationId(msg.senderId!, msg.receiverId!))
          .collection("chat")
          .doc(msg.id)
          .update({"reaction": emoji});
      Navigator.pop(dialogContext);

      // ✅ Clear selection using parentContext
      parentContext.read<ChatBloc>().add(ClearSelectionEvent());    },
    child: Text(emoji, style: TextStyle(fontSize: 22)),
  );
}