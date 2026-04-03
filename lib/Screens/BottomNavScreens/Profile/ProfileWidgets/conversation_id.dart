String getConversationId(String user1Id, String user2Id) {
  List<String> ids = [user1Id, user2Id]..sort();
  return ids.join('_');
}