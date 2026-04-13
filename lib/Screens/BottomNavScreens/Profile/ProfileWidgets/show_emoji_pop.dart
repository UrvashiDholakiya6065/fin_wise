import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Model/chat_model.dart';
import 'emoji_item.dart';

void showEmojiPopup(BuildContext parentContext, ChatModel msg) {
  showDialog(
    context: parentContext,
    barrierColor: Colors.transparent,

    builder: (dialogContext) {
      return Stack(
        children: [
          Positioned(
            bottom: 120,
            left: 40,
            right: 40,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    emojiItem("👍", msg,parentContext,dialogContext),
                    emojiItem("❤️", msg,parentContext,dialogContext),
                    emojiItem("😂", msg,parentContext,dialogContext),
                    emojiItem("😮", msg,parentContext,dialogContext),
                    emojiItem("😢", msg,parentContext,dialogContext),
                    emojiItem("🙏", msg,parentContext,dialogContext  ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
