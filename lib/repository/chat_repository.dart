import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicehub/model/chat_models.dart';

class ChatRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String currentUserId() => _auth.currentUser?.uid ?? '';

  String buildChatId(String a, String b) {
    return (a.compareTo(b) <= 0) ? '${a}_$b' : '${b}_$a';
  }

  Future<void> _ensureMessagesDoc(String chatID) async {
    final doc = _db.collection('messages').doc(chatID);
    final snap = await doc.get();
    if (!snap.exists) {
      await doc.set({'chatMessages': {}});
    }
  }

  Stream<List<MessageModel>> streamMessages(String chatID) {
    return _db
        .collection('messages')
        .doc(chatID)
        .collection('chatMessages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((q) => q.docs
            .map((d) => MessageModel.fromJson({...d.data(), 'messageID': d.id}))
            .toList());
  }

  Future<void> sendMessage({
    required String chatID,
    required String senderID,
    required String receiverID,
    required String text,
  }) async {
    await _ensureMessagesDoc(chatID);
    final msgRef = _db.collection('messages').doc(chatID).collection('chatMessages').doc();
    final now = DateTime.now();
    final msg = MessageModel(
      messageID: msgRef.id,
      message: text,
      messageType: 'text',
      senderID: senderID,
      receiverID: receiverID,
      seen: false,
      createdAt: now,
    );
    await msgRef.set(msg.toJson());

    final metaSender = ChatMeta(
      chatID: chatID,
      senderID: senderID,
      receiverID: receiverID,
      lastMessage: text,
      lastMessageTime: now,
      isLastMessageRead: false,
      otherUserID: receiverID,
      participants: [senderID, receiverID],
    );
    final metaReceiver = ChatMeta(
      chatID: chatID,
      senderID: senderID,
      receiverID: receiverID,
      lastMessage: text,
      lastMessageTime: now,
      isLastMessageRead: false,
      otherUserID: senderID,
      participants: [senderID, receiverID],
    );
    await _db.collection('users').doc(senderID).collection('chats').doc(chatID).set(metaSender.toJson());
    await _db.collection('users').doc(receiverID).collection('chats').doc(chatID).set(metaReceiver.toJson());
  }

  Stream<List<ChatMeta>> streamChats(String userID) {
    return _db
        .collection('users')
        .doc(userID)
        .collection('chats')
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((q) => q.docs.map((d) => ChatMeta.fromJson(d.data())).toList());
  }

  Future<void> markChatOpen({required String chatID, required String userID}) async {
    final batch = _db.batch();
    final msgsQuery = await _db
        .collection('messages')
        .doc(chatID)
        .collection('chatMessages')
        .where('receiverID', isEqualTo: userID)
        .where('seen', isEqualTo: false)
        .get();
    for (final d in msgsQuery.docs) {
      batch.update(d.reference, {'seen': true});
    }
    final userChatRef = _db.collection('users').doc(userID).collection('chats').doc(chatID);
    final userChatSnap = await userChatRef.get();
    if (userChatSnap.exists) {
      batch.update(userChatRef, {'isLastMessageRead': true});
      final otherId = userChatSnap.data()?['otherUserID']?.toString() ?? '';
      if (otherId.isNotEmpty) {
        final otherRef = _db.collection('users').doc(otherId).collection('chats').doc(chatID);
        final otherSnap = await otherRef.get();
        if (otherSnap.exists) {
          batch.update(otherRef, {'isLastMessageRead': true});
        }
      }
    }
    await batch.commit();
  }

  Future<String> getUserName(String userID) async {
    final u = await _db.collection('users').doc(userID).get();
    final data = u.data() ?? {};
    final name = (data['fullName'] as String?) ?? (data['displayName'] as String?) ?? '';
    return name.isEmpty ? userID : name;
  }
}
