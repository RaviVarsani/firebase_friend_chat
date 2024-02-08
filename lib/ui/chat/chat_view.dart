import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/conversation_model.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/utilities/app_strings.dart';

import '../../bloc/chatBloc/chat_bloc.dart';
import '../../bloc/chatBloc/chat_state.dart';
import '../conversation/conversation_page.dart';

class ChatView extends StatelessWidget {
  final UserModel authenticatedUser;

  ChatView({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ChatLoadFailure) {
          return Text(AppStrings.unableToLoadChats);
        } else if (state is ChatLoadSuccess) {
          return ChatList(
            authenticatedUser: authenticatedUser,
            chatsModel: state.chats,
          );
        }
        return Text('');
      },
    );
  }
}

class ChatList extends StatelessWidget {
  final List<ConversationModel> chatsModel;
  final UserModel authenticatedUser;

  ChatList(
      {Key? key, required this.chatsModel, required this.authenticatedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatsModel.isEmpty
        ? Center(
            child: Text(
            AppStrings.noChat,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ))
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  AppStrings.chatPage,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: chatsModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      final chat = chatsModel.elementAt(index);
                      final receiver = chat.creator.uid != authenticatedUser.uid
                          ? chat.creator
                          : chat.receiver;
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push<MaterialPageRoute>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConversationPage(
                                  receiver: receiver,
                                  sender: authenticatedUser,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(receiver.photoUrl),
                            ),
                            title: Text(
                              receiver.displayName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              receiver.email,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
