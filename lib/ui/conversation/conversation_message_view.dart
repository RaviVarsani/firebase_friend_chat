import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/message_model.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/utilities/app_colors.dart';
import 'package:friend_chat/utilities/app_strings.dart';
import 'package:intl/intl.dart';

import '../../bloc/message/messageReceiverBloc/message_receiver_bloc.dart';

class ConversationMessageView extends StatelessWidget {
  final UserModel loginUser;
  final UserModel receiver;

  ConversationMessageView(
      {Key? key, required this.loginUser, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageReceiverBloc, MessageReceiverState>(
      builder: (context, state) {
        if (state is MessageLoadInProgress) {
          return Center(child: Text(''));
        } else if (state is MessageLoadFailure) {
          return Text(AppStrings.unableToFetchMessage);
        } else if (state is MessageLoadSuccess) {
          return MessageListBuilder(
              messageModel: state.messageModel, loginUID: loginUser.uid);
        }
        return Text('');
      },
    );
  }
}

class MessageListBuilder extends StatelessWidget {
  final String loginUID;
  final List<MessageModel?> messageModel;

  MessageListBuilder(
      {Key? key, required this.loginUID, required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return messageModel.isEmpty
        ? Center(
            child: Text(
            AppStrings.noMessage,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ))
        : Container(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              itemCount: messageModel.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                final message = messageModel.elementAt(index);
                return MessageBody(
                  chatColor: message?.senderUID == loginUID,
                  messageModel: message,
                  index: index,
                );
              },
            ),
          );
  }
}

class MessageBody extends StatelessWidget {
  final bool chatColor;
  final MessageModel? messageModel;
  final int index;

  MessageBody(
      {Key? key,
      required this.chatColor,
      required this.messageModel,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Align(
        alignment: chatColor ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              chatColor ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: chatColor ? AppColors.primary : AppColors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Text(
                messageModel?.content ?? '',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Text(
                formatDate(formateTime: messageModel?.timeStamp ?? ''),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }

  formatDate({required String? formateTime}) {
    if (formateTime != null) {
      DateTime stringToTime = DateTime.parse(formateTime);
      var time = DateFormat("hh:mm:a").format(stringToTime);
      return time.toString();
    } else {}
  }
}
