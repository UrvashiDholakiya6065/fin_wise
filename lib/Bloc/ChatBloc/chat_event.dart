import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Model/user_model.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final ChatModel message;


  SendMessageEvent({required this.message,});
}

class LoadMessagesEvent extends ChatEvent {
  final String conversationId;
  final String currentUserId;

  LoadMessagesEvent(this.conversationId,this.currentUserId);
}
class MarkAsReadEvent extends ChatEvent {
  final String conversationId;
  final String currentUserId;

  MarkAsReadEvent({
    required this.conversationId,
    required this.currentUserId,
  });
}
class LoadUnreadCountEvent extends ChatEvent {
  final String conversationId;
  final String currentUserId;

  LoadUnreadCountEvent({
    required this.conversationId,
    required this.currentUserId,
  });
}


class ToggleSelectMessageEvent extends ChatEvent {
  final String messageId;

  ToggleSelectMessageEvent(this.messageId);
}

class ClearSelectionEvent extends ChatEvent {}

class DeleteMessageEvent extends ChatEvent {
  final String conversationId;

  DeleteMessageEvent(this.conversationId);
}