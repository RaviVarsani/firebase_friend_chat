import 'package:friend_chat/model/message_model.dart';
import 'package:friend_chat/provider/message_provider.dart';

class MessageRepository {
  final MessageProvider messageProvider;

  MessageRepository({required this.messageProvider});

  Future<void> sendMessage({required MessageModel messageModel}) async {
    await messageProvider.addMessage(messageMap: messageModel.toMap());
  }

  Stream<List<MessageModel?>> getMessages({required String conversationId}) {
    final messageMapStream =
        messageProvider.getMessages(conversationId: conversationId);
    return messageMapStream.map(
      (event) => event.map(
        (e) {
          return e != null ? MessageModel.fromMap(e) : null;
        },
      ).toList(),
    );
  }
}
