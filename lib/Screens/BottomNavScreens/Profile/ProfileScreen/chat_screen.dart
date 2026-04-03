// import 'package:fin_wise/Bloc/ChatBloc/chat_bloc.dart';
// import 'package:fin_wise/Bloc/ChatBloc/chat_event.dart';
// import 'package:fin_wise/Bloc/ChatBloc/chat_state.dart';
// import 'package:fin_wise/Model/chat_model.dart';
// import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// import '../ProfileWidgets/conversation_id.dart';
// import '../ProfileWidgets/msg_list_scroll.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String receiverName;
//   final String senderName;
//   final String receiverId;
//   final String currentId;
//
//   const ChatScreen(
//       {super.key, required this.receiverName, required this.receiverId, required this.currentId,required this.senderName});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [
//     {
//       "message": "Hey 👋",
//       "isMe": true,
//       "time": DateTime.now(),
//     },
//     {
//       "message": "Hello! What’s up?",
//       "isMe": false,
//       "time": DateTime.now(),
//     },
//   ];
//   late String conversationId;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     conversationId = getConversationId(widget.currentId, widget.receiverId);
//     final bloc = context.read<ChatBloc>();
//     bloc.add(LoadMessagesEvent(conversationId,widget.currentId));
//     // bloc.add(MarkAsReadEvent(conversationId: conversationId, currentUserId: widget.currentId));
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ChatBloc>().add(MarkAsReadEvent(
//         conversationId: conversationId,
//         currentUserId: widget.currentId,
//       ));
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("Reciver Id ${widget.receiverId}");
//     print("current Id ${widget.currentId}");
//     print("Reciever name ${widget.receiverName}");
//     print("current user name ${widget.senderName}");
//     return Scaffold(
//       backgroundColor: ColorsWidgets.white,
//
//       appBar: AppBar(
//         backgroundColor: ColorsWidgets.mainAppColor,
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: ColorsWidgets.lightGreen,
//               child: Text(widget.receiverName[0])
//             ),
//             SizedBox(width: 10),
//             Text(widget.receiverName),
//           ],
//         ),
//         actions: [
//           Icon(Icons.videocam),
//           SizedBox(width: 12),
//           Icon(Icons.call),
//           SizedBox(width: 12),
//           Icon(Icons.more_vert),
//         ],
//       ),
//
//       body: Column(
//         children: [
//
//           Expanded(
//             child: BlocBuilder<ChatBloc, ChatState>(
//               buildWhen: (previous, current) {
//                 return previous.messages.length != current.messages.length;
//               },
//               builder: (context, state) {
//
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   if (scrollController.hasClients) {
//                     scrollController.jumpTo(
//                       scrollController.position.maxScrollExtent,
//                     );
//                   }
//                 });
//
//                 return ListView.builder(
//                   controller: scrollController,
//                   padding: EdgeInsets.all(10),
//                   itemCount: state.messages.length,
//                   itemBuilder: (context, index) {
//
//                     print("Message length :::${state.messages.length}");
//                     final msg = state.messages[index];
//                     bool isMe = msg.senderId == widget.currentId;
//
//
//
//                     return Align(
//                       alignment: isMe
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment:
//                         isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//
//                         children: [
//                           if (!isMe)
//                             CircleAvatar(
//                               radius: 14,
//                               backgroundColor: ColorsWidgets.mainAppColor,
//                               child: Text(widget.receiverName[0],style: TextStyle(fontSize: 14),),
//                             ),
//
//                           if (!isMe) SizedBox(width: 6),
//                           Container(
//                             margin: EdgeInsets.symmetric(vertical: 4),
//                             padding: EdgeInsets.symmetric(horizontal: 12,
//                                 vertical: 8),
//                             constraints: BoxConstraints(maxWidth: 250),
//                             decoration: BoxDecoration(
//                               color: isMe
//                                   ? ColorsWidgets.mainAppColor
//                                   : ColorsWidgets.lightGreen,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                                 bottomLeft: isMe
//                                     ? Radius.circular(12)
//                                     : Radius.circular(0),
//                                 bottomRight: isMe
//                                     ? Radius.circular(0)
//                                     : Radius.circular(12),
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment:
//                               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,                              children: [
//                                 Text(
//                                   msg.msg.toString(),
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//
//                                 SizedBox(height: 4),
//
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       formatTime(msg.time),
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     SizedBox(width: 4),
//
//                                     if (isMe)
//                                       Icon(
//                                         msg.isRead ? Icons.done_all : Icons.done,
//                                         size: 14,
//                                         color: msg.isRead ? Colors.blue : Colors.grey,
//                                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (isMe) SizedBox(width: 6),
//
//                           if (isMe)
//                             CircleAvatar(
//                               radius: 14,
//                               backgroundColor: ColorsWidgets.lightGreen,
//                               child: Text(widget.senderName[0],style: TextStyle(fontSize: 14),),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//
//
//           Container(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               color: Colors.grey.shade200,
//               child: Row(
//                 children: [
//                   Icon(Icons.emoji_emotions_outlined),
//                   SizedBox(width: 6),
//
//                   Expanded(
//                     child: TextField(
//                       controller: messageController,
//                       minLines: 1,
//                       maxLines: null,
//                       keyboardType: TextInputType.multiline,
//                       decoration: InputDecoration(
//                         hintText: "Message",
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(width: 6),
//                   Icon(Icons.attach_file),
//                   SizedBox(width: 6),
//                   Icon(Icons.camera_alt),
//
//                   SizedBox(width: 6),
//
//                   CircleAvatar(
//                     backgroundColor: ColorsWidgets.mainAppColor,
//                     child: IconButton(
//                       icon: Icon(Icons.send, color: Colors.white),
//                       onPressed: () {
//                         print("Send Event");
//                         final message = ChatModel(
//                           senderId: widget.currentId,
//                           receiverId: widget.receiverId,
//                           msg: messageController.text.trim(),
//                           isMe: true,
//                           isRead: false,
//                           time: DateTime.now(),
//                         );
//                         context.read<ChatBloc>().add(SendMessageEvent(
//                             message: message
//                         ));
//                         messageController.clear();
//                         Future.delayed(Duration(milliseconds: 100), () {
//                           scrollController.animateTo(
//                             scrollController.position.maxScrollExtent,
//                             duration: Duration(milliseconds: 300),
//                             curve: Curves.easeOut,
//                           );
//                         });
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//         ],
//       ),
//     );
//   }
//
//   void sendMessage() {
//     if (messageController.text
//         .trim()
//         .isEmpty) return;
//
//     setState(() {
//       messages.add({
//         "message": messageController.text.trim(),
//         "isMe": true,
//         "time": DateTime.now(),
//       });
//     });
//
//     messageController.clear();
//   }
//
//   String formatTime(DateTime time) {
//     return DateFormat('hh:mm a').format(time);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_wise/Bloc/ChatBloc/chat_bloc.dart';
import 'package:fin_wise/Bloc/ChatBloc/chat_event.dart';
import 'package:fin_wise/Bloc/ChatBloc/chat_state.dart';
import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../ProfileWidgets/conversation_id.dart';
import '../ProfileWidgets/msg_list_scroll.dart';

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
        // title: Row(
        //   children: [
        //     CircleAvatar(
        //       backgroundColor: ColorsWidgets.lightGreen,
        //       child: Text(widget.receiverName[0]),
        //     ),
        //     SizedBox(width: 10),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(widget.receiverName),
        //
        //         StreamBuilder<DocumentSnapshot>(
        //           stream: FirebaseFirestore.instance
        //               .collection('users')
        //               .doc(widget.receiverId)
        //               .snapshots(),
        //           builder: (context, snapshot) {
        //
        //             if (!snapshot.hasData) {
        //               return Text("...");
        //             }
        //
        //             final data = snapshot.data!.data() as Map<String, dynamic>;
        //             bool isOnline = data['online'] ?? false;
        //             Timestamp? lastSeen = data['lastSeen'];
        //
        //             if (isOnline) {
        //               return Text(
        //                 "Online",
        //                 style: TextStyle(fontSize: 12),
        //               );
        //             } else {
        //               return Text(
        //                 "Last seen ${lastSeen != null ? formatTime(lastSeen.toDate()) : ""}",
        //                 style: TextStyle(fontSize: 12),
        //               );
        //             }
        //           },
        //         ),
        //       ],
        //     )
        //   ],
        // ),

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
                              if (!snapshot.hasData) {
                                return Text("...");
                              }

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
                                  "Last seen ${lastSeen != null ? formatTime(lastSeen.toDate()) : ""}",
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

        // actions: [
        //   Icon(Icons.videocam),
        //   SizedBox(width: 12),
        //   Icon(Icons.call),
        //   SizedBox(width: 12),
        //   Icon(Icons.more_vert),
        // ],
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

              return IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  context.read<ChatBloc>().add(
                    DeleteMessageEvent(conversationId),
                  );
                },
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
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(10),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final msg = state.messages[index];
                    bool isMe = msg.senderId == widget.currentId;
                    bool isSelected = msg.id != null &&
                        (state.selectedMessages ?? []).contains(msg.id);
                    return GestureDetector(
                      onLongPress: () {
                        if (msg.id != null) {
                          context.read<ChatBloc>().add(
                            ToggleSelectMessageEvent(msg.id!),
                          );
                        }
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
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                constraints: BoxConstraints(maxWidth: 250),
                                decoration: BoxDecoration(
                                  // color: isMe
                                  //     ? ColorsWidgets.mainAppColor
                                  //     : ColorsWidgets.lightGreen,
                                  color:
                                      (msg.id != null &&
                                          (state.selectedMessages ?? []).contains(
                                            msg.id,
                                          ))
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
                                    Text(
                                      msg.msg.toString(),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                    );
                  },
                );
              },
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
                Icon(Icons.camera_alt),
                SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor: ColorsWidgets.mainAppColor,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (messageController.text.trim().isEmpty) return;
                      final message = ChatModel(
                        senderId: widget.currentId,
                        receiverId: widget.receiverId,
                        msg: messageController.text.trim(),
                        isMe: true,
                        isRead: false,
                        time: DateTime.now(),
                      );
                      context.read<ChatBloc>().add(
                        SendMessageEvent(message: message),
                      );
                      messageController.clear();

                      Future.delayed(Duration(milliseconds: 100), () {
                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      });
                    },
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
