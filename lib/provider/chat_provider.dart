import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  final FirebaseFirestore firestore;

  ChatProvider({required this.firestore});

  Future<List<Map<String, dynamic>>> getChats(
      {required String loginUID}) async {
    final querySnap = await firestore
        .collection('conversations')
        .where('members', arrayContains: loginUID)
        .get();

    return querySnap.docs.map((e) => e.data()).toList();
  }
}
