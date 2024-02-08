import 'package:cloud_firestore/cloud_firestore.dart';

class MessageProvider {
  final FirebaseFirestore firestore;

  MessageProvider({required this.firestore});

  Future<void> addMessage({required Map<String, dynamic> messageMap}) async {
    await firestore
        .collection('messages')
        .add(messageMap)
        .then((value) => print(value.id));
  }

  Stream<List<Map<String, dynamic>?>> getMessages({
    required String conversationId,
  }) {
    final querySnapShotStream = firestore
        .collection('messages')
        .where('conversationId', isEqualTo: conversationId)
        .orderBy('timeStamp', descending: true)
        .snapshots();

    return querySnapShotStream.map(
      (event) => event.docs.map((e) => e.data()).toList(),
    );
  }
}
