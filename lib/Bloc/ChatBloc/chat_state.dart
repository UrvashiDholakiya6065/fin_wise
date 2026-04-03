import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

class ChatState extends Equatable {
  final List<ChatModel> messages;
  final ChatStatus? chatStatus;
  final int unreadCount;
  final List<String>? selectedMessages;
  final bool isSelectionMode;




  const  ChatState({
    required this.messages,
    this.unreadCount = 0,
   this.chatStatus,
   this.selectedMessages,
    this.isSelectionMode = false,


  });

  ChatState copyWith({
    List<ChatModel>? messages,
    int? unreadCount,ChatStatus? chatStatus,
    List<String>? selectedMessages,
    bool? isSelectionMode,

  }) {
    return ChatState(
        messages: messages ?? this.messages,
        unreadCount: unreadCount ?? this.unreadCount,
      chatStatus: chatStatus??this.chatStatus,
      selectedMessages: selectedMessages??this.selectedMessages,
        isSelectionMode:isSelectionMode??this.isSelectionMode
    );
  }

  @override
  List<Object?> get props => [messages, unreadCount,selectedMessages,isSelectionMode];
}
