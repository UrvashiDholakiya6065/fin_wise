import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_wise/Bloc/ChatBloc/chat_bloc.dart';
import 'package:fin_wise/Bloc/ChatBloc/chat_event.dart';
import 'package:fin_wise/Bloc/ChatBloc/chat_state.dart';
import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/chat_simmer_screen.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../ProfileWidgets/conversation_id.dart';
import '../ProfileWidgets/emoji_item.dart';
import '../ProfileWidgets/format_last_seen.dart';
import '../ProfileWidgets/msg_list_scroll.dart';
import '../ProfileWidgets/show_emoji_pop.dart';

class ChatScreen extends StatefulWidget {
  final String receiverName;
  final String senderName;
  final String receiverId;
  final String currentId;

  const ChatScreen({
    super.key,
    required this.receiverName,
    required this.receiverId,
    required this.currentId,
    required this.senderName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  late String conversationId;
  ChatModel? replyingMessage;

  @override
  void initState() {
    super.initState();
    conversationId = getConversationId(widget.currentId, widget.receiverId);
    final bloc = context.read<ChatBloc>();
    bloc.add(LoadMessagesEvent(conversationId, widget.currentId));
    bloc.add(ClearSelectionEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBloc>().add(
        MarkAsReadEvent(
          conversationId: conversationId,
          currentUserId: widget.currentId,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsWidgets.white,
      appBar: AppBar(
        backgroundColor: ColorsWidgets.mainAppColor,
        titleSpacing: 0,
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return state.isSelectionMode
                ? Text("${state.selectedMessages?.length} selected")
                : Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorsWidgets.lightGreen,
                        child: Text(widget.receiverName[0]),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.receiverName),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.receiverId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Text("...");
                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              bool isOnline = data['online'] ?? false;
                              Timestamp? lastSeen = data['lastSeen'];
                              if (isOnline) {
                                return Text(
                                  "Online",
                                  style: TextStyle(fontSize: 12),
                                );
                              } else {
                                return Text(
                                    "last seen ${formatLastSeen(lastSeen!.toDate())}",
                                  style: TextStyle(fontSize: 12),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),

        actions: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (!state.isSelectionMode) {
                return Row(
                  children: [
                    Icon(Icons.videocam),
                    SizedBox(width: 12),
                    Icon(Icons.call),
                    SizedBox(width: 12),
                    Icon(Icons.more_vert),
                  ],
                );
              }

              return Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.star_border),
                    onPressed: () {
                      // TODO: Star message
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      final selected = state.messages
                          .where((m) =>
                          (state.selectedMessages ?? []).contains(m.id))
                          .map((e) => e.msg)
                          .join("\n");

                      Clipboard.setData(ClipboardData(text: selected ?? ""));
                    },
                  ),

                  // 🗑 DELETE
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<ChatBloc>().add(
                        DeleteMessageEvent(conversationId),
                      );
                    },
                  ),

                  PopupMenuButton<String>(
                    onSelected: (value) {
                      final selectedMsg = state.messages.firstWhere(
                            (m) => (state.selectedMessages ?? []).contains(m.id),
                      );

                      if (value == "edit") {
                        final text = selectedMsg.msg ?? "";

                        if (messageController.text != text) {
                          messageController.text = text;
                        }

                        context.read<ChatBloc>().add(
                          SetEditMessageEvent(selectedMsg),
                        );

                      }
                      else if (value == "reply") {
                        context.read<ChatBloc>().add(SetReplyingMessageEvent(selectedMsg));
                      }
                    },
                    itemBuilder: (context) {
                      final selectedMsg = state.messages.firstWhere(
                            (m) => (state.selectedMessages ?? []).contains(m.id),
                      );

                      return [
                        if (selectedMsg.senderId == widget.currentId)
                          PopupMenuItem(
                            value: "edit",
                            child: Text("Edit"),
                          ),

                        PopupMenuItem(
                          value: "reply",
                          child: Text("Reply"),
                        ),
                        PopupMenuItem(
                          value: "info",
                          child: Text("Info"),
                        ),
                      ];
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.chatStatus == ChatStatus.loading) {
                  ChatShimmerScreen();
                }
                final unread = state.messages.where(
                  (msg) => msg.senderId != widget.currentId && !msg.isRead,
                );
                if (unread.isNotEmpty) {
                  context.read<ChatBloc>().add(
                    MarkAsReadEvent(
                      conversationId: conversationId,
                      currentUserId: widget.currentId,
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  }
                });

                if (state.replyingMessage != null) {
                  setState(() {
                    replyingMessage = state.replyingMessage;
                  });
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(10),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final msg = state.messages[index];
                    bool isMe = msg.senderId == widget.currentId;
                    bool isSelected =
                        msg.id != null &&
                        (state.selectedMessages ?? []).contains(msg.id);
                    return Dismissible(
                      key: Key(msg.id ?? index.toString()),
                      direction: isMe
                          ? DismissDirection.startToEnd
                          : DismissDirection.endToStart,
                      background: Container(
                        color: Colors.greenAccent,
                        alignment: isMe
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.reply, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        context.read<ChatBloc>().add(
                          SetReplyingMessageEvent(msg),
                        );
                        return false;
                      },
                      child: GestureDetector(
                        onLongPress: () {
                          if (msg.id != null) {
                            context.read<ChatBloc>().add(
                              ToggleSelectMessageEvent(msg.id!),
                            );
                          }
                          showEmojiPopup(context,msg);
                        },
                        onTap: () {
                          if (state.isSelectionMode) {
                            context.read<ChatBloc>().add(
                              ToggleSelectMessageEvent(msg.id!),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          color: isSelected
                              ? Colors.green.withOpacity(0.2)
                              : Colors.transparent,
                          child: Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isMe)
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: ColorsWidgets.mainAppColor,
                                    child: Text(
                                      widget.receiverName[0],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                if (!isMe) SizedBox(width: 6),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: 250,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            (msg.id != null &&
                                                (state.selectedMessages ?? [])
                                                    .contains(msg.id))
                                            ? Colors.grey.shade300
                                            : (isMe
                                                  ? ColorsWidgets.mainAppColor
                                                  : ColorsWidgets.lightGreen),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                          bottomLeft: isMe
                                              ? Radius.circular(12)
                                              : Radius.circular(0),
                                          bottomRight: isMe
                                              ? Radius.circular(0)
                                              : Radius.circular(12),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: isMe
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          if (msg.replyMessage != null)
                                            Builder(
                                              builder: (context) {
                                                final repliedMsg =
                                                    state.messages
                                                        .where(
                                                          (m) =>
                                                              m.id ==
                                                              msg.replyMessage,
                                                        )
                                                        .isNotEmpty
                                                    ? state.messages.firstWhere(
                                                        (m) =>
                                                            m.id ==
                                                            msg.replyMessage,
                                                      )
                                                    : null;

                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    bottom: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        repliedMsg != null
                                                            ? (repliedMsg.senderId ==
                                                                      widget
                                                                          .currentId
                                                                  ? "You"
                                                                  : widget
                                                                        .receiverName)
                                                            : "",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green,
                                                        ),
                                                      ),

                                                      Text(
                                                        repliedMsg?.msg ??
                                                            "Message not available",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          Text(
                                            msg.msg.toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),

                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (msg.isEdited == true)
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 4),
                                                  child: Text(
                                                    "Edited",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                      fontStyle: FontStyle.italic,
                                                    ),
                                                  ),
                                                ),

                                              Text(
                                                formatTime(msg.time),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              if (isMe)
                                                Icon(
                                                  msg.isRead
                                                      ? Icons.done_all
                                                      : Icons.done,
                                                  size: 14,
                                                  color: msg.isRead
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (msg.reaction != null &&
                                        msg.reaction!.isNotEmpty)
                                      Positioned(
                                        bottom: -8,
                                        right: isMe ? 10 : null,
                                        left: isMe ? null : 10,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            msg.reaction!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if (isMe) SizedBox(width: 6),
                                if (isMe)
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: ColorsWidgets.lightGreen,
                                    child: Text(
                                      widget.senderName[0],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          if (replyingMessage != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          replyingMessage!.msg ?? "",
                          style: TextStyle(color: Colors.black87),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          replyingMessage!.senderId == widget.currentId
                              ? "You"
                              : widget.receiverName,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20),
                    onPressed: () {
                      setState(() {
                        replyingMessage = null;
                      });
                      context.read<ChatBloc>().add(ClearSelectionEvent());
                    },
                  ),
                ],
              ),
            ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Icon(Icons.emoji_emotions_outlined),
                SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Message",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.attach_file),
                SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor: ColorsWidgets.mainAppColor,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (messageController.text.trim().isEmpty) return;

                        final bloc = context.read<ChatBloc>();
                        final state = bloc.state;

                        if (state.editingMessage != null) {
                          bloc.add(
                            EditMessageEvent(
                              conversationId: conversationId,
                              messageId: state.editingMessage!.id!,
                              newMsg: messageController.text.trim(),
                            ),
                          );
                          bloc.add(ClearEditMessageEvent());

                        } else {
                          bloc.add(
                            SendMessageEvent(
                              message: ChatModel(
                                senderId: widget.currentId,
                                receiverId: widget.receiverId,
                                msg: messageController.text.trim(),
                                isMe: true,
                                isRead: false,
                                time: DateTime.now(),
                                replyMessage: replyingMessage?.id,
                                replySenderId: replyingMessage?.senderId,
                              ),
                            ),
                          );
                        }

                        messageController.clear();
                        setState(() {
                          replyingMessage = null;
                        });

                        bloc.add(ClearReplyingMessageEvent());
                      }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }
}
