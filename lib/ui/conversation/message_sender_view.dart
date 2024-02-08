import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/message_model.dart';
import 'package:friend_chat/utilities/app_colors.dart';

import '../../bloc/message/messageSenderBloc/message_sender_bloc.dart';
import '../../bloc/message/messageSenderBloc/message_sender_event.dart';
import '../../bloc/message/messageSenderBloc/message_sender_state.dart';

class ConversationSenderView extends StatefulWidget {
  final String? conversationId;
  final String senderUID;
  final String receiverUID;
  final String receiverName;

  ConversationSenderView({
    Key? key,
    this.conversationId,
    required this.senderUID,
    required this.receiverUID,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ConversationSenderView> createState() => _ConversationSenderViewState();
}

class _ConversationSenderViewState extends State<ConversationSenderView> {
  late final TextEditingController messageTextController;
  late String msg;

  @override
  void initState() {
    super.initState();
    messageTextController = TextEditingController();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: messageTextController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 5, left: 20, right: 20),
                hintText: 'Message ${widget.receiverName}',
                hintStyle: TextStyle(fontSize: 12, color: AppColors.black),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<MessageSenderBloc, MessageSenderState>(
            listener: (context, state) {
              if (state is MessageSendSuccess) {}
            },
            builder: (context, state) {
              if (state is MessageSendInProgress) {
              } else if (state is MessageSendFailure) {
                return Center(child: Icon(Icons.error));
              }
              return Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: IconButton(
                        icon:
                            Icon(Icons.send, size: 22, color: AppColors.white),
                        onPressed: () {
                          msg = messageTextController.text.trim();
                          if (msg.isNotEmpty) {
                            BlocProvider.of<MessageSenderBloc>(context).add(
                              MessageSend(
                                messageModel: MessageModel(
                                  content: msg,
                                  conversationId: widget.conversationId ?? '',
                                  senderUID: widget.senderUID,
                                  receiverUID: widget.receiverUID,
                                  timeStamp: DateTime.now().toString(),
                                ),
                              ),
                            );
                            messageTextController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
