import 'package:bloc/bloc.dart';
import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

import '../../Network/Repository/repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final Repository repository;

  ChatBloc(this.repository) : super(ChatState(messages: [])) {
    on<SendMessageEvent>(onSendMessage);
    on<LoadMessagesEvent>(onLoadMessages);
    on<MarkAsReadEvent>(markIsRead);
    on<LoadUnreadCountEvent>(unReadCount);
    on<ToggleSelectMessageEvent>(toggleMessage);
    on<ClearSelectionEvent>(clearSelection);
    on<DeleteMessageEvent>(deleteMessage);
  }

  Future<void> onSendMessage(SendMessageEvent event, emit) async {
    emit(state.copyWith(chatStatus: ChatStatus.loading));
    try {
      await repository.sendMessage(

        chatModel: event.message,
      );
      emit(state.copyWith(chatStatus: ChatStatus.success));
    } catch (e) {
      emit(state.copyWith(chatStatus: ChatStatus.error));
    }
  }

  Future<void> onLoadMessages(LoadMessagesEvent event,
      Emitter<ChatState> emit,) async {
    await emit.forEach<List<ChatModel>>(
      repository.getMessages(event.conversationId),
      onData: (messages) {
        return state.copyWith(messages: messages);
      },
    );
  }

  Future<void> markIsRead(MarkAsReadEvent event,
      Emitter<ChatState> emit,) async {
    final updatedMessages = state.messages.map((msg) {
      if (msg.receiverId == event.currentUserId) {
        return msg.copyWith(isRead: true);
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updatedMessages));

    await repository.markMessagesAsRead(
      event.conversationId,
      event.currentUserId,
    );
  }

  Future<void> unReadCount(LoadUnreadCountEvent event,
      Emitter<ChatState> emit,) async {
    await emit.forEach<int>(
      repository.getUnreadCount(
        event.conversationId,
        event.currentUserId,
      ),
      onData: (count) {
        return state.copyWith(unreadCount: count);
      },
    );
  }


  void toggleMessage (ToggleSelectMessageEvent event,emit){
    final selected = List<String>.from(state.selectedMessages??[]);

    if (selected.contains(event.messageId)) {
      selected.remove(event.messageId);
    } else {
      selected.add(event.messageId);
    }

    emit(state.copyWith(
      selectedMessages: selected,
      isSelectionMode: selected.isNotEmpty,
    ));
  }

void clearSelection(ClearSelectionEvent event,emit){
  emit(state.copyWith(
    selectedMessages: [],
    isSelectionMode: false,
  ));

}



Future<void> deleteMessage(DeleteMessageEvent event,emit) async {
  await repository.deleteMessages(
    event.conversationId,
      List<String>.from(state.selectedMessages??[])  );

  final updated = state.messages
      .where((msg) => !state.selectedMessages!.contains(msg.id))
      .toList();

  emit(state.copyWith(
    messages: updated,
    selectedMessages: [],
    isSelectionMode: false,
  ));
}

}

