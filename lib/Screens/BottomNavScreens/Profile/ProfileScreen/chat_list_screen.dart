import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../ProfileWidgets/chat_item.dart';
import '../ProfileWidgets/chat_list_smmmer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(LoadChatListEvent());

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        if (state.chatListStatus == ChatListStatus.error) {
          return Center(child: Text("Error loading chats"));
        }
        return  Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (state.chatListStatus == ChatListStatus.error) {
                  return Center(child: Text("Error loading chats"));
                }   
                if (state.chatListStatus == ChatListStatus.loading) {
                  final count = state.selectedRole == "user"
                      ? state.admins.length
                      : state.users.length;

                  return  ChatListShimmer(itemCount: count,);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selectedRole == "user" ? "Admins" : "Users",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.more_vert),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              "Search message",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.selectedRole == "user"
                            ? state.admins.length
                            : state.users.length,
                        itemBuilder: (context, index) {

                          final item = state.selectedRole == "user"
                              ? state.admins[index]
                              : state.users[index];

                          return  GestureDetector(
                              onTap: () async {
                                // final repo = Repository();

                                final currentUser = state.currentUser?.uid;
                                final currentUser2 = state.currentUser;
                                print("Current user i chat list screen:::$currentUser");
                                final otherUserId = item.uid;
                                appRoute.push(AppRoutePath.chatScreen.path,extra: {
                                  "currentUserId": currentUser,
                                  "otherUserId": otherUserId,
                                  "name": item.fullName,
                                  "senderName": currentUser2?.fullName
                                },);
                                // final bloc = context.read<ChatBloc>();
                                // late String conversationId;
                                //
                                // conversationId = getConversationId(currentUser!, otherUserId);
                                // bloc.add(MarkAsReadEvent(conversationId: conversationId, currentUserId:currentUser));

                              },
                              child: chatItem(item,state.currentUser!.uid));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}