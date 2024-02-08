import 'package:friend_chat/model/conversation_model.dart';
import 'package:friend_chat/provider/conversation_provider.dart';

class ConversationRepository {
  final ConversationProvider conversationProvider;

  ConversationRepository({required this.conversationProvider});

  Future<ConversationModel?> getConversation(
      {required String senderID, required String receiverID}) async {
    final conversationMap = await conversationProvider.getConversationId(
        senderID: senderID, receiverID: receiverID);

    if (conversationMap == null) {
      return null;
    } else {
      return ConversationModel.fromMap(conversationMap);
    }
  }

  Future<String> createConversation(
      {required ConversationModel conversationModel}) async {
    final conversationId = await conversationProvider.createConversation(
      conversation: conversationModel.toMap(),
    );
    return conversationId;
  }
}
