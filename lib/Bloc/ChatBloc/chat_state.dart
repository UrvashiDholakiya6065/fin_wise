import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

class ChatState extends Equatable {
  final List<ChatModel> messages;
  final ChatStatus? chatStatus;
  final int unreadCount;
  final List<String>? selectedMessages;
  final bool isSelectionMode;
  final ChatModel? replyingMessage;
  final ChatModel? editingMessage;




  const  ChatState({
    required this.messages,
    this.unreadCount = 0,
   this.chatStatus,
   this.selectedMessages,
    this.isSelectionMode = false,
    this.replyingMessage,
    this.editingMessage


  });

  ChatState copyWith({
    List<ChatModel>? messages,
    int? unreadCount,ChatStatus? chatStatus,
    List<String>? selectedMessages,
    bool? isSelectionMode,
    ChatModel? replyingMessage,
     ChatModel? editingMessage,


  }) {
    return ChatState(
        messages: messages ?? this.messages,
        unreadCount: unreadCount ?? this.unreadCount,
      chatStatus: chatStatus??this.chatStatus,
      selectedMessages: selectedMessages??this.selectedMessages,
        isSelectionMode:isSelectionMode??this.isSelectionMode,
      replyingMessage: replyingMessage,
      editingMessage: editingMessage??editingMessage

    );
  }

  @override
  List<Object?> get props => [messages, unreadCount,selectedMessages,isSelectionMode,replyingMessage,editingMessage];
}
