import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationProvider {
  final FirebaseFirestore firestore;

  ConversationProvider({required this.firestore});

  Future<Map<String, dynamic>?> getConversationId(
      {required String senderID, required String receiverID}) async {
    final members = [senderID, receiverID];

    final conversationQuerySnap =
        await firestore.collection('conversations').where(
      'members',
      whereIn: [members, members.reversed.toList()],
    ).get();
    log(conversationQuerySnap.docs.length.toString());
    if (conversationQuerySnap.docs.isNotEmpty) {
      return conversationQuerySnap.docs.first.data();
    }
    return null;
  }

  Future<String> createConversation(
      {required Map<String, dynamic> conversation}) async {
    final conversationRef =
        await firestore.collection('conversations').add(conversation);

    await conversationRef.update({'id': conversationRef.id});
    return conversationRef.id;
  }
}
