
import 'package:flutter/cupertino.dart';

ScrollController scrollController = ScrollController();
void scrollToBottom() {
  if (scrollController.hasClients) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}